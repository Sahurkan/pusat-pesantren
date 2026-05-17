import 'package:flutter/material.dart';

// 1. HALAMAN UNTUK FITUR YANG SEDANG DIKEMBANGKAN
class HalamanFitur extends StatelessWidget {
  final String judul;
  HalamanFitur({required this.judul});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Color(0xFF1B5E20),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              "Fitur $judul",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Halaman ini sedang dalam tahap pengembangan\n(Minggu ke-5 sesuai Blueprint)",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. HALAMAN TAHFIDZ (CONTOH TAMPILAN LIST)
class HalamanTahfidz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progres Tahfidz"),
        backgroundColor: Color(0xFF1B5E20),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _cardHafalan("Surah Al-Baqarah", "Ayat 1 - 50", "Lancar"),
          _cardHafalan("Surah Ali-Imran", "Ayat 1 - 20", "Perlu Murojaah"),
          _cardHafalan("Surah An-Nisa", "Belum Setoran", "-"),
        ],
      ),
    );
  }

  Widget _cardHafalan(String surah, String progres, String status) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(Icons.menu_book, color: Color(0xFF1B5E20)),
        title: Text(surah, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(progres),
        trailing: Text(
          status,
          style: TextStyle(
            color: status == "Lancar" ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
