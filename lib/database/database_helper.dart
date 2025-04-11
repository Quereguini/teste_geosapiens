import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  static DatabaseHelper get instance => _instance;

  static Database? _database;

  static const _dbName = 'app.db';
  static const _dbVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_pescador TEXT,
        nome_peixe TEXT ,
        aparelho_pesca INTEGER ,
        quantidade_kilos INTEGER ,
        geolocalizacao REAL
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> userData) async {
    final db = await database;
    return await db.insert('users', userData);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateUser(Map<String, dynamic> userData) async {
    final db = await database;
    int id = userData['id'];
    return await db.update('users', userData, where: 'id = ?', whereArgs: [id]);
  }
}
