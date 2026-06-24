import 'package:flutter/material.dart';
import 'db_helper.dart';

// --- HALAMAN TAHFIDZ (SISTEM INPUT) ---
class HalamanTahfidz extends StatefulWidget {
  @override
  _HalamanTahfidzState createState() => _HalamanTahfidzState();
}

class _HalamanTahfidzState extends State<HalamanTahfidz> {
  final _surahController = TextEditingController();
  final _ayatController = TextEditingController();
  List<Map<String, dynamic>> _listData = [];

  @override
  void initState() { super.initState(); _muatData(); }
  void _muatData() async {
    final d = await DbHelper.instance.ambilData('tahfidz');
    setState(() => _listData = d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Progres Tahfidz"), backgroundColor: Color(0xFF1B5E20)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextField(controller: _surahController, decoration: InputDecoration(labelText: "Nama Surah")),
                    TextField(controller: _ayatController, decoration: InputDecoration(labelText: "Hafalan Ayat/Juz")),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1B5E20)),
                        onPressed: () async {
                          if (_surahController.text.isNotEmpty) {
                            await DbHelper.instance.simpanData('tahfidz', {
                              'surah': _surahController.text,
                              'ayat': _ayatController.text,
                              'status': 'Lancar'
                            });
                            _surahController.clear(); _ayatController.clear();
                            _muatData();
                          }
                        },
                        child: Text("SIMPAN HAFALAN", style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Text("RIWAYAT SETORAN HAFALAN:", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _listData.length,
              itemBuilder: (context, i) => Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListTile(
                  leading: Icon(Icons.book, color: Colors.green),
                  title: Text(_listData[i]['surah'] ?? ''),
                  subtitle: Text("Ayat/Juz: ${_listData[i]['ayat'] ?? ''}"),
                  trailing: Text(_listData[i]['status'] ?? '', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// --- HALAMAN DINAMIS UNTUK ALL FITUR (TABUNGAN, KESEHATAN, SPP, DISIPLIN, IZIN) ---
class HalamanFitur extends StatefulWidget {
  final String judul;
  HalamanFitur({required this.judul});
  @override
  _HalamanFiturState createState() => _HalamanFiturState();
}

class _HalamanFiturState extends State<HalamanFitur> {
  final _inputController1 = TextEditingController();
  final _inputController2 = TextEditingController();
  List<Map<String, dynamic>> _riwayatData = [];
  String namaTabel = '';
  String label1 = '';
  String label2 = '';

  @override
  void initState() {
    super.initState();
    _aturKonfigurasiTabel();
    _muatData();
  }

  void _aturKonfigurasiTabel() {
    if (widget.judul == "Kesehatan") {
      namaTabel = 'kesehatan'; label1 = 'Keluhan Sakit'; label2 = 'Obat yang Diberikan';
    } else if (widget.judul == "Pembayaran SPP") {
      namaTabel = 'spp'; label1 = 'Untuk Bulan (Contoh: Mei)'; label2 = 'Nominal Pembayaran (Rp)';
    } else if (widget.judul == "Kedisiplinan") {
      namaTabel = 'disiplin'; label1 = 'Jenis Pelanggaran'; label2 = 'Poin Sanksi';
    } else if (widget.judul == "Perizinan") {
      namaTabel = 'izin'; label1 = 'Alasan Izin Pulang / Keluar'; label2 = 'Lama Izin (Hari)';
    }
  }

  void _muatData() async {
    if (namaTabel.isNotEmpty) {
      final d = await DbHelper.instance.ambilData(namaTabel);
      setState(() => _riwayatData = d);
    }
  }

  void _prosesSimpan() async {
    if (_inputController1.text.isNotEmpty && _inputController2.text.isNotEmpty) {
      Map<String, dynamic> dataSimpan = {};
      
      // Mengonversi input angka dengan aman menggunakan int.tryParse
      int nilaiAngka2 = int.tryParse(_inputController2.text) ?? 0;

      if (namaTabel == 'kesehatan') {
        dataSimpan = {'keluhan': _inputController1.text, 'obat': _inputController2.text, 'tanggal': 'Hari Ini'};
      } else if (namaTabel == 'spp') {
        dataSimpan = {'bulan': _inputController1.text, 'jumlah': nilaiAngka2, 'status': 'Lunas'};
      } else if (namaTabel == 'disiplin') {
        dataSimpan = {'pelanggaran': _inputController1.text, 'poin': nilaiAngka2, 'tanggal': 'Hari Ini'};
      } else if (namaTabel == 'izin') {
        dataSimpan = {'alasan': _inputController1.text, 'status': 'Disetujui', 'tanggal': '${_inputController2.text} Hari'};
      }

      await DbHelper.instance.simpanData(namaTabel, dataSimpan);
      _inputController1.clear(); _inputController2.clear();
      _muatData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data ${widget.judul} Berhasil Disimpan!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.judul == "Riwayat Aktivitas" || widget.judul == "Menu Lainnya") {
      return Scaffold(
        appBar: AppBar(title: Text(widget.judul), backgroundColor: Color(0xFF1B5E20)),
        body: Center(child: Text("Riwayat Log Sistem Sinkron Otomatis (Aktif)", style: TextStyle(color: Colors.grey))),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Fitur ${widget.judul}"), backgroundColor: Color(0xFF1B5E20)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextField(controller: _inputController1, decoration: InputDecoration(labelText: label1)),
                    TextField(
                      controller: _inputController2, 
                      decoration: InputDecoration(labelText: label2),
                      keyboardType: (namaTabel == 'spp' || namaTabel == 'disiplin') ? TextInputType.number : TextInputType.text,
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1B5E20)),
                        onPressed: _prosesSimpan,
                        child: Text("SIMPAN DATA", style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Text("DATA TERCATAT DI DATABASE:", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _riwayatData.length,
              itemBuilder: (context, i) {
                String titleText = '';
                String subText = '';
                if (namaTabel == 'kesehatan') {
                  titleText = "Sakit: ${_riwayatData[i]['keluhan'] ?? ''}"; subText = "Obat: ${_riwayatData[i]['obat'] ?? ''}";
                } else if (namaTabel == 'spp') {
                  titleText = "Bulan: ${_riwayatData[i]['bulan'] ?? ''}"; subText = "Total: Rp ${_riwayatData[i]['jumlah'] ?? 0} (${_riwayatData[i]['status'] ?? ''})";
                } else if (namaTabel == 'disiplin') {
                  titleText = "Pelanggaran: ${_riwayatData[i]['pelanggaran'] ?? ''}"; subText = "Sanksi: ${_riwayatData[i]['poin'] ?? 0} Poin";
                } else if (namaTabel == 'izin') {
                  titleText = "Izin: ${_riwayatData[i]['alasan'] ?? ''}"; subText = "Durasi: ${_riwayatData[i]['tanggal'] ?? ''} (${_riwayatData[i]['status'] ?? ''})";
                }
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ListTile(
                    leading: Icon(Icons.circle, color: Color(0xFF1B5E20), size: 12),
                    title: Text(titleText, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(subText),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
