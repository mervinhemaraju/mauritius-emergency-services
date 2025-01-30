import 'dart:convert';
import 'dart:typed_data';
import 'package:mauritius_emergency_services/data/sources/mes.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import '../local/database_helper.dart';

class MesServiceLocalDataSource implements MesDataSource {
  final LocalDatabase localDatabase;

  MesServiceLocalDataSource({required this.localDatabase});

  Future<Uint8List?> _downloadIcon(String iconUrl) async {
    try {
      final response = await http.get(Uri.parse(iconUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<List<Service>> getAllServices(String _) async {
    // Get the local database
    final db = await localDatabase.database;

    // Get all services from the cache
    final List<Map<String, dynamic>> maps = await db.query(LocalDatabase.table);

    // Convert the db data to a List<Service>
    return List.generate(
      maps.length,
      (i) {
        return Service(
          identifier: maps[i]['identifier'],
          name: maps[i]['name'],
          type: maps[i]['type'],
          icon: maps[i]['icon'],
          emails: List<String>.from(jsonDecode(maps[i]['emails'])),
          mainContact: maps[i]['main_contact'],
          otherContacts: List<int>.from(jsonDecode(maps[i]['other_contacts'])),
          iconData: maps[i]['icon_data'],
        );
      },
    );
  }

  Future<void> cacheServices(List<Service> services) async {
    // Get the local database
    final db = await localDatabase.database;

    // Get existing services from cache
    final existingServices = await db.query(
      LocalDatabase.table,
      columns: ['identifier', 'icon', 'icon_data'],
    );

    // Create a map of existing services for quick lookup
    final existingServiceMap = {
      for (var service in existingServices)
        service['identifier'] as String: service
    };

    await db.transaction(
      (txn) async {
        for (var service in services) {
          final existing = existingServiceMap[service.identifier];
          Uint8List? iconData;

          // Only download icon if:
          // 1. Service doesn't exist in cache, or
          // 2. Service exists but icon URL changed, or
          // 3. Service exists but has no icon data
          if (existing == null ||
              existing['icon'] != service.icon ||
              existing['icon_data'] == null) {
            iconData = await _downloadIcon(service.icon);
          } else {
            // Use existing icon data
            iconData = existing['icon_data'] as Uint8List?;
          }

          // Insert the service into the cache
          await txn.insert(
            LocalDatabase.table,
            {
              'identifier': service.identifier,
              'name': service.name,
              'type': service.type,
              'icon': service.icon,
              'emails': jsonEncode(service.emails),
              'main_contact': service.mainContact,
              'other_contacts': jsonEncode(service.otherContacts),
              'icon_data': iconData,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      },
    );
  }

  Future<void> clearCache() async {
    // Clear the services
    final db = await localDatabase.database;
    await db.delete(LocalDatabase.table);
  }
}
