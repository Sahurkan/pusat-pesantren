import 'package:flutter/material.dart';

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
            const Text(
              "Pencatatan Keuangan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _kotakRingkasan("Pemasukan", "Rp 15.200.000", Colors.green),
                _kotakRingkasan("Pengeluaran", "Rp 4.800.000", Colors.red),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Riwayat Transaksi", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    title: Text("Pembayaran Iuran Bulanan"),
                    subtitle: Text("05 Mei 2026"),
                    trailing: Text("+ Rp 500.000", style: TextStyle(color: Colors.green)),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Pembelian Perlengkapan"),
                    subtitle: Text("03 Mei 2026"),
                    trailing: Text("- Rp 250.000", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _kotakRingkasan(String judul, String nilai, Color warna) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warna.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(judul, style: TextStyle(color: warna)),
          const SizedBox(height: 8),
          Text(nilai, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: warna)),
        ],
      ),
    );
  }
}
