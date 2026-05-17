import 'package:sqflite/sqflite.dart'; // Pastikan sudah install sqflite
import 'package:path/path.dart';       // Pastikan sudah install path

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pesantren_pro.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Membuat tabel utama
    await db.execute('''
      CREATE TABLE santri(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        nis TEXT,
        saldo INTEGER,
        keterangan TEXT
      )
    ''');

    // Memasukkan data awal (biar aplikasi nggak kosong)
    await db.insert('santri', {
      'nama': 'MOH SAHUR',
      'nis': '20241220091',
      'saldo': 1500000,
      'keterangan': 'Saldo Awal'
    });
  }

  // Fungsi untuk menyimpan data baru
  Future<int> simpanTransaksi(String nama, int jumlah) async {
    final db = await instance.database;
    return await db.insert('santri', {
      'nama': nama,
      'nis': '20241220091',
      'saldo': jumlah,
      'keterangan': 'Top Up Tabungan'
    });
  }

  // Fungsi untuk mengambil data agar tampil di layar
  Future<List<Map<String, dynamic>>> ambilSemuaData() async {
    final db = await instance.database;
    return await db.query('santri', orderBy: 'id DESC');
  }
}
