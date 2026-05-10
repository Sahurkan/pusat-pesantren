import 'package:flutter/material.dart';

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
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profil Pengguna"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Ubah Kata Sandi"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.storage),
            title: const Text("Cadangkan Data"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Tentang Aplikasi"),
            subtitle: const Text("Versi 1.0.0 - Sistem Informasi Pondok"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
