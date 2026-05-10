import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi Lokasi & Buat Database
  Future<Database> _initDatabase() async {
    Directory dokumenDir = await getApplicationDocumentsDirectory();
    String path = join(dokumenDir.path, 'db_pondok.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Buat Tabel-Tabel yang dibutuhkan
  Future _onCreate(Database db, int version) async {
    // Tabel Data Santri
    await db.execute('''
      CREATE TABLE santri (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        alamat TEXT,
        asal_daerah TEXT,
        kelas TEXT,
        nama_wali TEXT,
        no_hp TEXT
      )
    ''');

    // Tabel Pengumuman
    await db.execute('''
      CREATE TABLE pengumuman (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        isi TEXT,
        tanggal TEXT
      )
    ''');

    // Tabel Keuangan
    await db.execute('''
      CREATE TABLE keuangan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        jenis TEXT, -- pemasukan / pengeluaran
        keterangan TEXT,
        jumlah INTEGER,
        tanggal TEXT
      )
    ''');
  }

  // ============== CONTOH FUNGSI CRUD ==============
  // Tambah Data Santri
  Future<int> tambahSantri(Map<String, dynamic> data) async {
    Database db = await database;
    return await db.insert('santri', data);
  }

  // Ambil Semua Data Santri
  Future<List<Map<String, dynamic>>> ambilSemuaSantri() async {
    Database db = await database;
    return await db.query('santri');
  }

  // Ubah Data Santri
  Future<int> ubahSantri(int id, Map<String, dynamic> data) async {
    Database db = await database;
    return await db.update('santri', data, where: 'id = ?', whereArgs: [id]);
  }

  // Hapus Data Santri
  Future<int> hapusSantri(int id) async {
    Database db = await database;
    return await db.delete('santri', where: 'id = ?', whereArgs: [id]);
  }
}
