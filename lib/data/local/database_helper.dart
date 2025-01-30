import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  // Database vars
  static const _databaseName = "services_db.db";
  static const _databaseVersion = 1;
  static const table = 'services';
  static Database? _database;

  // Constructor
  const LocalDatabase._privateConstructor();

  // An instance of the database
  static final LocalDatabase instance =
      const LocalDatabase._privateConstructor();

  // Get the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

// Loads the databsae
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // The onCreate function of the DB
  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $table (
        identifier TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        icon TEXT NOT NULL,
        emails TEXT NOT NULL,
        main_contact INTEGER NOT NULL,
        other_contacts TEXT NOT NULL,
        icon_data BLOB
      )
    ''',
    );
  }
}
