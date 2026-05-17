import 'package:flutter/material.dart';

class HalamanData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // HEADER HIJAU
          Container(
            padding: EdgeInsets.only(top: 60, left: 20, bottom: 40),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF1B5E20), // Hijau Pesantren
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PUSAT PESANTREN", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Dashboard Utama", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          
          // CARD PROFIL MOH SAHUR
          Transform.translate(
            offset: Offset(0, -25),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  CircleAvatar(radius: 25, child: Icon(Icons.person)),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MOH SAHUR", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("20241220091", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // GRID MENU (FITUR UTAMA)
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(20),
              crossAxisCount: 4,
              children: [
                _buatIcon(Icons.book, "Tahfidz"),
                _buatIcon(Icons.health_and_safety, "Kesehatan"),
                _buatIcon(Icons.wallet, "Tabungan"),
                _buatIcon(Icons.payment, "SPP"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: Colors.green[800], child: Icon(icon, color: Colors.white)),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}
