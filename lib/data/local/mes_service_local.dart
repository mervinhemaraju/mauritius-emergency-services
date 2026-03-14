import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mauritius_emergency_services/data/helpers/database_helper.dart';
import 'package:mauritius_emergency_services/data/sources/mes_service_source.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:sqflite/sqflite.dart';

class MesServiceLocal implements MesServiceSource {
  final LocalDatabase localDatabase;

  const MesServiceLocal({required this.localDatabase});

  // ---------------------------------------------------------------------------
  // MesServiceSource
  // ---------------------------------------------------------------------------

  @override
  Future<List<Service>> getAllServices(String _) async {
    final db = await localDatabase.database;
    final rows = await db.query(LocalDatabase.table);

    return rows
        .map(
          (row) => Service(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            type: row['type'] as String,
            icon: row['icon'] as String,
            emails: List<String>.from(
              jsonDecode(row['emails'] as String) as List,
            ),
            mainContact: row['main_contact'] as int,
            otherContacts: List<int>.from(
              jsonDecode(row['other_contacts'] as String) as List,
            ),
            iconData: row['icon_data'] as Uint8List?,
          ),
        )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Cache management
  // ---------------------------------------------------------------------------

  Future<void> cacheServices(List<Service> services) async {
    final db = await localDatabase.database;

    // Build a lookup map of what is already cached (icon URL + blob).
    final existing = await db.query(
      LocalDatabase.table,
      columns: ['identifier', 'icon', 'icon_data'],
    );
    final existingMap = <String, Map<String, Object?>>{
      for (final row in existing) row['identifier'] as String: row,
    };

    await db.transaction((txn) async {
      for (final service in services) {
        final cached = existingMap[service.identifier];

        // Re-download the icon only when necessary.
        final Uint8List? iconData;
        if (cached == null ||
            cached['icon'] != service.icon ||
            cached['icon_data'] == null) {
          iconData = await _downloadIcon(service.icon);
        } else {
          iconData = cached['icon_data'] as Uint8List?;
        }

        await txn.insert(LocalDatabase.table, {
          'identifier': service.identifier,
          'name': service.name,
          'type': service.type,
          'icon': service.icon,
          'emails': jsonEncode(service.emails),
          'main_contact': service.mainContact,
          'other_contacts': jsonEncode(service.otherContacts),
          'icon_data': iconData,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> clearCache() async {
    final db = await localDatabase.database;
    await db.delete(LocalDatabase.table);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Future<Uint8List?> _downloadIcon(String iconUrl) async {
    try {
      final response = await http.get(Uri.parse(iconUrl));
      if (response.statusCode == 200) return response.bodyBytes;
    } catch (_) {
      // Non-fatal — the app can fall back to a placeholder icon.
    }
    return null;
  }
}
