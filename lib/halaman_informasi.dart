import 'package:flutter/material.dart';

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
            const Text(
              "Informasi & Jadwal",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text("Jadwal Pengajian Harian"),
                      subtitle: const Text("Shubuh, Ashar, Maghrib, Isya"),
                      leading: const Icon(Icons.schedule, color: Color(0xFF2E7D32)),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text("Pengumuman Baru"),
                      subtitle: const Text("Pendaftaran santri baru gelombang 2"),
                      leading: const Icon(Icons.campaign, color: Colors.blueGrey),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text("Kalender Kegiatan"),
                      subtitle: const Text("Kegiatan bulan Mei - Juni 2026"),
                      leading: const Icon(Icons.calendar_month, color: Colors.orange),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
