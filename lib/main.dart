import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Informasi Pondok',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2E7D32),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF2E7D32),
          secondary: const Color(0xFF81C784),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Arial',
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _indeksTerpilih = 0;

  final List<Widget> _daftarHalaman = [
    const KontenUtama(),
    const HalamanData(),
    const HalamanInformasi(),
    const HalamanKeuangan(),
    const HalamanPengaturan(),
  ];

  void _pilihHalaman(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistem Informasi Pondok Pesantren"),
        centerTitle: true,
      ),
      body: _daftarHalaman[_indeksTerpilih],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indeksTerpilih,
        onTap: _pilihHalaman,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Data'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informasi'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Keuangan'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
      ),
    );
  }
}

class KontenUtama extends StatelessWidget {
  const KontenUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Assalamu'alaikum,", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text("Selamat datang di Sistem Informasi Pondok Pesantren", style: TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Menu Utama", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buatMenu(Icons.person, "Data Santri"),
              _buatMenu(Icons.school, "Data Pengajar"),
              _buatMenu(Icons.event_note, "Jadwal Kegiatan"),
              _buatMenu(Icons.announcement, "Pengumuman"),
              _buatMenu(Icons.payment, "Pembayaran"),
              _buatMenu(Icons.fact_check, "Absensi"),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Pengumuman Terbaru", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Libur Akhir Pekan", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Kegiatan belajar mengajar libur pada hari Sabtu dan Minggu.", style: TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatMenu(IconData ikon, String teks) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(ikon, size: 40, color: const Color(0xFF2E7D32)),
          const SizedBox(height: 8),
          Text(teks, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class HalamanData extends StatelessWidget {
  const HalamanData({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pengelolaan Data", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(leading: const Icon(Icons.person, color: Color(0xFF2E7D32)), title: const Text("Data Santri"), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: (){}),
            const Divider(),
            ListTile(leading: const Icon(Icons.school, color: Color(0xFF2E7D32)), title: const Text("Data Pengajar & Pengurus"), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: (){}),
            const Divider(),
            ListTile(leading: const Icon(Icons.search, color: Color(0xFF2E7D32)), title: const Text("Pencarian Data"), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: (){}),
          ],
        ),
      ),
    );
  }
}

class HalamanInformasi extends StatelessWidget {
  const HalamanInformasi({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Informasi & Jadwal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(child: ListView(children: [
              Card(child: ListTile(title: const Text("Jadwal Pengajian Harian"), subtitle: const Text("Shubuh, Ashar, Maghrib, Isya"), leading: const Icon(Icons.schedule, color: Color(0xFF2E7D32)), onTap: (){})),
              Card(child: ListTile(title: const Text("Pengumuman Baru"), subtitle: const Text("Pendaftaran santri baru gelombang 2"), leading: const Icon(Icons.campaign, color: Colors.blueGrey), onTap: (){})),
              Card(child: ListTile(title: const Text("Kalender Kegiatan"), subtitle: const Text("Kegiatan bulan Mei - Juni 2026"), leading: const Icon(Icons.calendar_month, color: Colors.orange), onTap: (){})),
            ]))
          ],
        ),
      ),
    );
  }
}

class HalamanKeuangan extends StatelessWidget {
  const HalamanKeuangan({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pencatatan Keuangan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _kotakRingkasan("Pemasukan", "Rp 15.200.000", Colors.green),
              _kotakRingkasan("Pengeluaran", "Rp 4.800.000", Colors.red),
            ]),
            const SizedBox(height: 20),
            const Text("Riwayat Transaksi", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(child: ListView(children: const [
              ListTile(title: Text("Pembayaran Iuran Bulanan"), subtitle: Text("05 Mei 2026"), trailing: Text("+ Rp 500.000", style: TextStyle(color: Colors.green))),
              Divider(),
              ListTile(title: Text("Pembelian Perlengkapan"), subtitle: Text("03 Mei 2026"), trailing: Text("- Rp 250.000", style: TextStyle(color: Colors.red))),
            ]))
          ],
        ),
      ),
    );
  }
  Widget _kotakRingkasan(String judul, String nilai, Color warna) {
    return Container(width: 150, padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: warna.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Column(children: [Text(judul, style: TextStyle(color: warna)), const SizedBox(height: 8), Text(nilai, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: warna))]));
  }
}

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Pengaturan Aplikasi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ListTile(leading: const Icon(Icons.person), title: const Text("Profil Pengguna"), onTap: (){}),
          const Divider(),
          ListTile(leading: const Icon(Icons.lock), title: const Text("Ubah Kata Sandi"), onTap: (){}),
          const Divider(),
          ListTile(leading: const Icon(Icons.storage), title: const Text("Cadangkan Data"), onTap: (){}),
          const Divider(),
          ListTile(leading: const Icon(Icons.info), title: const Text("Tentang Aplikasi"), subtitle: const Text("Versi 1.0.0 - Sistem Informasi Pondok"), onTap: (){}),
        ],
      ),
    );
  }
}
