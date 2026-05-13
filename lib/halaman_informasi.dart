import 'package:flutter/material.dart';

class HalamanInformasi extends StatelessWidget {
  const HalamanInformasi({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jadwal Pengajian")),
      body: const Center(child: Text("Jadwal: \nSubuh: Kitab Kuning\nAshar: Bahasa Arab")),
    );
  }
}
