import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;
  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pesantren_full_v1.db'); // DB baru biar fresh
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // 1. Tabel Tabungan/Santri
    await db.execute('''
      CREATE TABLE tabungan(id INTEGER PRIMARY KEY AUTOINCREMENT, jumlah INTEGER, tanggal TEXT)
    ''');
    // 2. Tabel Tahfidz
    await db.execute('''
      CREATE TABLE tahfidz(id INTEGER PRIMARY KEY AUTOINCREMENT, surah TEXT, ayat TEXT, status TEXT)
    ''');
    // 3. Tabel Kesehatan
    await db.execute('''
      CREATE TABLE kesehatan(id INTEGER PRIMARY KEY AUTOINCREMENT, keluhan TEXT, obat TEXT, tanggal TEXT)
    ''');
    // 4. Tabel SPP
    await db.execute('''
      CREATE TABLE spp(id INTEGER PRIMARY KEY AUTOINCREMENT, bulan TEXT, jumlah INTEGER, status TEXT)
    ''');
    // 5. Tabel Disiplin
    await db.execute('''
      CREATE TABLE disiplin(id INTEGER PRIMARY KEY AUTOINCREMENT, pelanggaran TEXT, poin INTEGER, tanggal TEXT)
    ''');
    // 6. Tabel Izin
    await db.execute('''
      CREATE TABLE izin(id INTEGER PRIMARY KEY AUTOINCREMENT, alasan TEXT, status TEXT, tanggal TEXT)
    ''');
  }

  // --- FUNGSI SIMPAN & AMBIL DATA (ALL IN ONE) ---
  Future<int> simpanData(String tabel, Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert(tabel, data);
  }

  Future<List<Map<String, dynamic>>> ambilData(String tabel) async {
    final db = await instance.database;
    return await db.query(tabel, orderBy: 'id DESC');
  }
}
