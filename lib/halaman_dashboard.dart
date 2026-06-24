import 'package:flutter/material.dart';
import 'main.dart'; 
import 'halaman_tabungan.dart';
import 'halaman_fitur_umum.dart';
import 'halaman_data.dart';

class HalamanDashboard extends StatefulWidget {
  @override
  _HalamanDashboardState createState() => _HalamanDashboardState();
}

class _HalamanDashboardState extends State<HalamanDashboard> {
  
  void _prosesLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi Keluar"),
        content: Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Batal")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HalamanLogin()),
              );
            },
            child: Text("Ya, Keluar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pusat Pesantren"),
        backgroundColor: Color(0xFF1B5E20),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: _prosesLogout,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HEADER HIJAU
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFF1B5E20),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  "Selamat Datang di Sistem Informasi",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // 2. CARD PROFIL
            Transform.translate(
              offset: Offset(0, -25),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[100],
                    child: Icon(Icons.person, color: Colors.green[900]),
                  ),
                  title: Text("MOH SAHUR", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("NPM: 20241220091"),
                  trailing: Icon(Icons.verified, color: Colors.blue),
                ),
              ),
            ),

            // 3. MENU UTAMA GIRI
            Padding(
              padding: EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buatTombolMenu(context, "Tahfidz", Icons.book, Colors.orange, HalamanTahfidz()),
                  _buatTombolMenu(context, "Tabungan", Icons.account_balance_wallet, Colors.teal, HalamanTabungan()),
                  _buatTombolMenu(context, "Kesehatan", Icons.local_hospital, Colors.red, HalamanFitur(judul: "Kesehatan")),
                  _buatTombolMenu(context, "Pembayaran SPP", Icons.monetization_on, Colors.blue, HalamanFitur(judul: "Pembayaran SPP")),
                  _buatTombolMenu(context, "Kedisiplinan", Icons.gavel, Colors.purple, HalamanFitur(judul: "Kedisiplinan")),
                  _buatTombolMenu(context, "Perizinan", Icons.assignment_turned_in, Colors.brown, HalamanFitur(judul: "Perizinan")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buatTombolMenu(BuildContext context, String judul, IconData ikon, Color warna, Widget halamanTujuan) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => halamanTujuan));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: warna.withOpacity(0.2),
              child: Icon(ikon, size: 30, color: warna),
            ),
            SizedBox(height: 10),
            Text(judul, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
