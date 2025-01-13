// import 'package:mauritius_emergency_services/core/models/service.dart';
// import 'package:mauritius_emergency_services/data/api/mes_remote.dart';
// import 'package:sqflite/sqflite.dart';

// class MesLocalDataSource implements MesDataSource {
//   final Database database;

//   MesLocalDataSource(this.database);

//   static Future<void> createTable(Database db) async {
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS services(
//         id INTEGER PRIMARY KEY,
//         name TEXT NOT NULL,
//         description TEXT NOT NULL,
//         language TEXT NOT NULL
//       )
//     ''');
//   }

//   @override
//   Future<List<Service>> getAllServices(String lang) async {
//     final List<Map<String, dynamic>> maps = await database.query(
//       'services',
//       where: 'language = ?',
//       whereArgs: [lang],
//     );

//     return List.generate(maps.length, (i) => Service.fromJson(maps[i]));
//   }

//   // Future<void> cacheServices(List<Service> services) async {
//   //   final batch = database.batch();

//   //   // Clear existing services for the given language
//   //   batch.delete(
//   //     'services',
//   //     where: 'language = ?',
//   //     whereArgs: [services.first.language],
//   //   );

//   //   // Insert new services
//   //   for (var service in services) {
//   //     batch.insert(
//   //       'services',
//   //       service.toJson(),
//   //       conflictAlgorithm: ConflictAlgorithm.replace,
//   //     );
//   //   }

//   //   await batch.commit();
//   // }
// }
