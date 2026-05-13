import 'package:flutter/material.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengaturan Sistem")),
      body: const ListTile(
        leading: Icon(Icons.info),
        title: Text("Pusat Pesantren v1.0"),
        subtitle: Text("Sistem Manajemen Digital Pondok"),
      ),
    );
  }
}
