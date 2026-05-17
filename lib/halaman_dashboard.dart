import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'halaman_tabungan.dart';    // Pastikan file ini sudah kamu buat
import 'halaman_fitur_umum.dart';  // Pastikan file ini sudah kamu buat

class HalamanDashboard extends StatefulWidget {
  @override
  _HalamanDashboardState createState() => _HalamanDashboardState();
}

class _HalamanDashboardState extends State<HalamanDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HEADER HIJAU PESANTREN (Sesuai Referensi Al Kautsar)
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selamat Datang,", style: TextStyle(color: Colors.white70, fontSize: 14)),
                  Text("SISTEM INFORMASI PESANTREN", 
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // 2. CARD PROFIL (Floating Card)
            Transform.translate(
              offset: Offset(0, -25),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[100],
                    child: Icon(Icons.person, color: Colors.green[800]),
                  ),
                  title: Text("MOH SAHUR", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("NPM: 20241220091"),
                  trailing: Icon(Icons.verified, color: Colors.blue, size: 20),
                ),
              ),
            ),

            // 3. GRID MENU (8 Fitur Utama - Berfungsi Semua)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.85, // Mengatur agar kotak menu pas
                children: [
                  _menuItem(context, Icons.menu_book, "Tahfidz", 
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanTahfidz()))),
                  
                  _menuItem(context, Icons.local_hospital, "Kesehatan", 
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanFitur(judul: "Kesehatan")))),
                  
                  _menuItem(context, Icons.account_balance_wallet, "Tabungan", 
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanTabungan()))),
                  
                  _menuItem(context, Icons.payments, "SPP", 
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanFitur(judul: "Pembayaran SPP")))),
                  
                  _menuItem(context, Icons.gavel, "Disiplin", 
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanFitur(judul: "Kedisiplinan")))),
                  
                  _menuItem(context, Icons.assignment_ind, "Izin", 
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanFitur(judul: "Perizinan")))),
                  
                  _menuItem(context, Icons.history, "Riwayat", 
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanFitur(judul: "Riwayat Aktivitas")))),
                  
                  _menuItem(context, Icons.more_horiz, "Lainnya", 
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanFitur(judul: "Menu Lainnya")))),
                ],
              ),
            ),

            // 4. BAGIAN PENGUMUMAN (Sesuai Blueprint)
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pengumuman Terbaru", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Text(
                      "Ujian Akhir Semester (UAS) akan dilaksanakan pada tanggal 20 Mei 2026. Mohon persiapkan administrasi Anda.",
                      style: TextStyle(color: Colors.orange[900], fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET TOMBOL MENU (Dibuat terpisah agar rapi)
  Widget _menuItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF1B5E20),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
