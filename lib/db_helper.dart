import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;
  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pesantren_modern.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE santri(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT, alamat TEXT, asal TEXT, kelas TEXT, wali TEXT, hp TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE keuangan(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        jenis TEXT, keterangan TEXT, jumlah REAL, tanggal TEXT
      )
    ''');
  }
}
