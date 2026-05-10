import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const PondokApp());
}

class PondokApp extends StatelessWidget {
  const PondokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Informasi Pondok',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MainPage(),
    );
  }
}

class Santri {
  int? id;
  String nama;
  String alamat;
  String asal;
  String kelas;
  String wali;
  String hp;

  Santri({
    this.id,
    required this.nama,
    required this.alamat,
    required this.asal,
    required this.kelas,
    required this.wali,
    required this.hp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'alamat': alamat,
      'asal': asal,
      'kelas': kelas,
      'wali': wali,
      'hp': hp,
    };
  }

  factory Santri.fromMap(Map<String, dynamic> map) {
    return Santri(
      id: map['id'],
      nama: map['nama'],
      alamat: map['alamat'],
      asal: map['asal'],
      kelas: map['kelas'],
      wali: map['wali'],
      hp: map['hp'],
    );
  }
}

class Keuangan {
  int? id;
  String jenis;
  String keterangan;
  int jumlah;
  String tanggal;

  Keuangan({
    this.id,
    required this.jenis,
    required this.keterangan,
    required this.jumlah,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jenis': jenis,
      'keterangan': keterangan,
      'jumlah': jumlah,
      'tanggal': tanggal,
    };
  }

  factory Keuangan.fromMap(Map<String, dynamic> map) {
    return Keuangan(
      id: map['id'],
      jenis: map['jenis'],
      keterangan: map['keterangan'],
      jumlah: map['jumlah'],
      tanggal: map['tanggal'],
    );
  }
}

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    String path = p.join(await getDatabasesPath(), 'pondok.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE santri(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            alamat TEXT,
            asal TEXT,
            kelas TEXT,
            wali TEXT,
            hp TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE keuangan(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            jenis TEXT,
            keterangan TEXT,
            jumlah INTEGER,
            tanggal TEXT
          )
        ''');
      },
    );
  }

  // SANTRI
  static Future<void> insertSantri(Santri santri) async {
    final db = await database;
    await db.insert('santri', santri.toMap());
  }

  static Future<List<Santri>> getSantri() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('santri');

    return List.generate(maps.length, (i) {
      return Santri.fromMap(maps[i]);
    });
  }

  static Future<void> updateSantri(Santri santri) async {
    final db = await database;

    await db.update(
      'santri',
      santri.toMap(),
      where: 'id = ?',
      whereArgs: [santri.id],
    );
  }

  static Future<void> deleteSantri(int id) async {
    final db = await database;

    await db.delete(
      'santri',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // KEUANGAN
  static Future<void> insertKeuangan(Keuangan keuangan) async {
    final db = await database;
    await db.insert('keuangan', keuangan.toMap());
  }

  static Future<List<Keuangan>> getKeuangan() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'keuangan',
      orderBy: 'id DESC',
    );

    return List.generate(maps.length, (i) {
      return Keuangan.fromMap(maps[i]);
    });
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const SantriPage(),
    const InformasiPage(),
    const KeuanganPage(),
    const PengaturanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Santri',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Informasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Keuangan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget menuItem(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.green),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistem Informasi Pondok'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assalamu\'alaikum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Selamat datang di Sistem Informasi Pondok Pesantren',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                menuItem(Icons.person_add, 'Tambah Santri'),
                menuItem(Icons.list, 'Daftar Santri'),
                menuItem(Icons.schedule, 'Jadwal & Informasi'),
                menuItem(Icons.money, 'Catat Keuangan'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Pengumuman Penting',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.campaign,
                  color: Colors.green,
                ),
                title: const Text(
                  'Kegiatan pengajian dimulai pukul 19:30 WIB',
                ),
                subtitle: const Text(
                  'Harap seluruh santri hadir tepat waktu.',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SantriPage extends StatefulWidget {
  const SantriPage({super.key});

  @override
  State<SantriPage> createState() => _SantriPageState();
}

class _SantriPageState extends State<SantriPage> {
  List<Santri> santriList = [];

  @override
  void initState() {
    super.initState();
    loadSantri();
  }

  Future<void> loadSantri() async {
    final data = await DBHelper.getSantri();

    setState(() {
      santriList = data;
    });
  }

  void showForm({Santri? santri}) {
    final nama = TextEditingController(text: santri?.nama);
    final alamat = TextEditingController(text: santri?.alamat);
    final asal = TextEditingController(text: santri?.asal);
    final kelas = TextEditingController(text: santri?.kelas);
    final wali = TextEditingController(text: santri?.wali);
    final hp = TextEditingController(text: santri?.hp);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          santri == null ? 'Tambah Santri' : 'Edit Santri',
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nama,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                controller: alamat,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                ),
              ),
              TextField(
                controller: asal,
                decoration: const InputDecoration(
                  labelText: 'Asal Daerah',
                ),
              ),
              TextField(
                controller: kelas,
                decoration: const InputDecoration(
                  labelText: 'Kelas',
                ),
              ),
              TextField(
                controller: wali,
                decoration: const InputDecoration(
                  labelText: 'Nama Wali',
                ),
              ),
              TextField(
                controller: hp,
                decoration: const InputDecoration(
                  labelText: 'No HP',
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (santri == null) {
                await DBHelper.insertSantri(
                  Santri(
                    nama: nama.text,
                    alamat: alamat.text,
                    asal: asal.text,
                    kelas: kelas.text,
                    wali: wali.text,
                    hp: hp.text,
                  ),
                );
              } else {
                await DBHelper.updateSantri(
                  Santri(
                    id: santri.id,
                    nama: nama.text,
                    alamat: alamat.text,
                    asal: asal.text,
                    kelas: kelas.text,
                    wali: wali.text,
                    hp: hp.text,
                  ),
                );
              }

              Navigator.pop(context);
              loadSantri();
            },
            child: const Text('Simpan'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Santri'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => showForm(),
        child: const Icon(Icons.add),
      ),
      body: santriList.isEmpty
          ? const Center(
        child: Text('Belum ada data santri'),
      )
          : ListView.builder(
        itemCount: santriList.length,
        itemBuilder: (context, index) {
          final santri = santriList[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  santri.nama[0],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(santri.nama),
              subtitle: Text(
                '${santri.kelas} • ${santri.asal}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showForm(santri: santri);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await DBHelper.deleteSantri(santri.id!);
                      loadSantri();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class InformasiPage extends StatelessWidget {
  const InformasiPage({super.key});

  Widget jadwalCard(
      String title,
      String time,
      ) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.access_time,
          color: Colors.green,
        ),
        title: Text(title),
        subtitle: Text(time),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi & Jadwal'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jadwal Pengajian',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            jadwalCard(
              'Pengajian Kitab',
              'Ba\'da Maghrib',
            ),
            jadwalCard(
              'Tahfidz Al-Qur\'an',
              'Ba\'da Subuh',
            ),
            const SizedBox(height: 20),
            const Text(
              'Jadwal Belajar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            jadwalCard(
              'Belajar Bahasa Arab',
              '08:00 - 10:00',
            ),
            jadwalCard(
              'Belajar Fiqih',
              '13:00 - 15:00',
            ),
            const SizedBox(height: 20),
            const Text(
              'Pengumuman',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Colors.green,
                ),
                title: Text(
                  'Hari Jumat akan diadakan kerja bakti.',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({super.key});

  @override
  State<KeuanganPage> createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage> {
  List<Keuangan> transaksi = [];

  int totalMasuk = 0;
  int totalKeluar = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await DBHelper.getKeuangan();

    int masuk = 0;
    int keluar = 0;

    for (var item in data) {
      if (item.jenis == 'Pemasukan') {
        masuk += item.jumlah;
      } else {
        keluar += item.jumlah;
      }
    }

    setState(() {
      transaksi = data;
      totalMasuk = masuk;
      totalKeluar = keluar;
    });
  }

  void tambahTransaksi() {
    final jenis = ValueNotifier<String>('Pemasukan');
    final keterangan = TextEditingController();
    final jumlah = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Transaksi'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: jenis,
                builder: (context, value, child) {
                  return DropdownButtonFormField<String>(
                    value: value,
                    items: const [
                      DropdownMenuItem(
                        value: 'Pemasukan',
                        child: Text('Pemasukan'),
                      ),
                      DropdownMenuItem(
                        value: 'Pengeluaran',
                        child: Text('Pengeluaran'),
                      ),
                    ],
                    onChanged: (v) {
                      jenis.value = v!;
                    },
                  );
                },
              ),
              TextField(
                controller: keterangan,
                decoration: const InputDecoration(
                  labelText: 'Keterangan',
                ),
              ),
              TextField(
                controller: jumlah,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Uang',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await DBHelper.insertKeuangan(
                Keuangan(
                  jenis: jenis.value,
                  keterangan: keterangan.text,
                  jumlah: int.parse(jumlah.text),
                  tanggal: DateTime.now()
                      .toString()
                      .substring(0, 10),
                ),
              );

              Navigator.pop(context);
              loadData();
            },
            child: const Text('Simpan'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int saldo = totalMasuk - totalKeluar;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keuangan Pondok'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: tambahTransaksi,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  infoKeuangan(
                    'Total Pemasukan',
                    'Rp $totalMasuk',
                  ),
                  infoKeuangan(
                    'Total Pengeluaran',
                    'Rp $totalKeluar',
                  ),
                  infoKeuangan(
                    'Saldo Akhir',
                    'Rp $saldo',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Riwayat Transaksi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: transaksi.isEmpty
                  ? const Center(
                child: Text(
                  'Belum ada transaksi',
                ),
              )
                  : ListView.builder(
                itemCount: transaksi.length,
                itemBuilder: (context, index) {
                  final item = transaksi[index];

                  return Card(
                    child: ListTile(
                      leading: Icon(
                        item.jenis == 'Pemasukan'
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: item.jenis == 'Pemasukan'
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(item.keterangan),
                      subtitle: Text(item.tanggal),
                      trailing: Text(
                        'Rp ${item.jumlah}',
                        style: TextStyle(
                          color:
                          item.jenis == 'Pemasukan'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoKeuangan(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  Widget item(
      IconData icon,
      String title,
      String subtitle,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            item(
              Icons.info,
              'Info Aplikasi',
              'Sistem Informasi Pondok Pesantren v1.0',
            ),
            item(
              Icons.person,
              'Profil Pengguna',
              'Administrator Pondok',
            ),
          ],
        ),
      ),
    );
  }
}