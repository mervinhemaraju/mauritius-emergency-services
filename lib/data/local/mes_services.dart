import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';
import 'package:sqflite/sqflite.dart';

class MesServiceLocalDataSource implements MesDataSource {
  final Database database;

  MesServiceLocalDataSource(this.database);

  static Future<void> createTables(Database db) async {
    // Main services table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS services(
        identifier TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        icon TEXT NOT NULL,
        main_contact INTEGER NOT NULL,
        language TEXT NOT NULL
      )
    ''');

    // Table for service emails
    await db.execute('''
      CREATE TABLE IF NOT EXISTS service_emails(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        service_identifier TEXT NOT NULL,
        email TEXT NOT NULL,
        FOREIGN KEY (service_identifier) REFERENCES services (identifier) ON DELETE CASCADE
      )
    ''');

    // Table for service other contacts
    await db.execute('''
      CREATE TABLE IF NOT EXISTS service_contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        service_identifier TEXT NOT NULL,
        contact_id INTEGER NOT NULL,
        FOREIGN KEY (service_identifier) REFERENCES services (identifier) ON DELETE CASCADE
      )
    ''');

    // Create indexes
    await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_services_language ON services(language)');
    await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_service_emails ON service_emails(service_identifier)');
    await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_service_contacts ON service_contacts(service_identifier)');
  }

  @override
  Future<List<Service>> getAllServices(String lang) async {
    // Get all services for the specified language
    final List<Map<String, dynamic>> serviceMaps = await database.query(
      'services',
      where: 'language = ?',
      whereArgs: [lang],
    );

    // If no services found, return empty list
    if (serviceMaps.isEmpty) {
      return [];
    }

    // Build list of services with their related data
    List<Service> services = [];
    for (var serviceMap in serviceMaps) {
      // Get emails for this service
      final List<Map<String, dynamic>> emailMaps = await database.query(
        'service_emails',
        where: 'service_identifier = ?',
        whereArgs: [serviceMap['identifier']],
      );

      // Get other contacts for this service
      final List<Map<String, dynamic>> contactMaps = await database.query(
        'service_contacts',
        where: 'service_identifier = ?',
        whereArgs: [serviceMap['identifier']],
      );

      // Create service object with all its data
      services.add(Service(
        identifier: serviceMap['identifier'],
        name: serviceMap['name'],
        type: serviceMap['type'],
        icon: serviceMap['icon'],
        mainContact: serviceMap['main_contact'],
        emails: emailMaps.map((m) => m['email'] as String).toList(),
        otherContacts: contactMaps.map((m) => m['contact_id'] as int).toList(),
      ));
    }

    return services;
  }

  Future<void> cacheServices(List<Service> services, String lang) async {
    await database.transaction((txn) async {
      // Clear existing services for the given language
      await txn.delete(
        'services',
        where: 'language = ?',
        whereArgs: [lang],
      );

      // Insert new services and their related data
      for (var service in services) {
        // Insert main service data
        await txn.insert(
          'services',
          {
            'identifier': service.identifier,
            'name': service.name,
            'type': service.type,
            'icon': service.icon,
            'main_contact': service.mainContact,
            'language': lang,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Insert emails
        for (String email in service.emails) {
          await txn.insert(
            'service_emails',
            {
              'service_identifier': service.identifier,
              'email': email,
            },
          );
        }

        // Insert other contacts
        for (int contactId in service.otherContacts) {
          await txn.insert(
            'service_contacts',
            {
              'service_identifier': service.identifier,
              'contact_id': contactId,
            },
          );
        }
      }
    });
  }
}
