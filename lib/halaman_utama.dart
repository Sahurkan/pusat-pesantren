import 'package:flutter/material.dart';
import 'halaman_data.dart';
import 'halaman_informasi.dart';
import 'halaman_keuangan.dart';
import 'halaman_pengaturan.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _indeksTerpilih = 0;

  // Daftar halaman yang akan ditampilkan
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Informasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
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

// Konten halaman beranda
class KontenUtama extends StatelessWidget {
  const KontenUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sambutan
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
                Text(
                  "Assalamu'alaikum,",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Text(
                  "Selamat datang di Sistem Informasi Pondok Pesantren",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Menu Cepat
          const Text(
            "Menu Utama",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
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

          // Pengumuman Terbaru
          const Text(
            "Pengumuman Terbaru",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Libur Akhir Pekan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Kegiatan belajar mengajar libur pada hari Sabtu dan Minggu.",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
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
