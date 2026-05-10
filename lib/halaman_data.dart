import 'package:flutter/material.dart';

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
            const Text(
              "Pengelolaan Data",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF2E7D32)),
              title: const Text("Data Santri"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Fungsi ke daftar santri nanti
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.school, color: Color(0xFF2E7D32)),
              title: const Text("Data Pengajar & Pengurus"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Fungsi ke daftar pengajar nanti
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.search, color: Color(0xFF2E7D32)),
              title: const Text("Pencarian Data"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Fungsi pencarian nanti
              },
            ),
          ],
        ),
      ),
    );
  }
}
