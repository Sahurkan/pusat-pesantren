import 'package:flutter/material.dart';
import 'db_helper.dart';

class HalamanData extends StatefulWidget {
  const HalamanData({super.key});
  @override
  State<HalamanData> createState() => _HalamanDataState();
}

class _HalamanDataState extends State<HalamanData> {
  List<Map<String, dynamic>> _dataSantri = [];

  void _refreshData() async {
    final db = await DbHelper.instance.database;
    final res = await db.query('santri');
    setState(() => _dataSantri = res);
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Santri")),
      body: ListView.builder(
        itemCount: _dataSantri.length,
        itemBuilder: (context, i) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            title: Text(_dataSantri[i]['nama'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Kelas: ${_dataSantri[i]['kelas']} - ${_dataSantri[i]['asal']}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final db = await DbHelper.instance.database;
                await db.delete('santri', where: 'id = ?', whereArgs: [_dataSantri[i]['id']]);
                _refreshData();
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[800],
        onPressed: () => _showForm(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showForm() {
    final namaC = TextEditingController();
    final kelasC = TextEditingController();
    final asalC = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Tambah Santri", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: namaC, decoration: const InputDecoration(labelText: "Nama Lengkap")),
            TextField(controller: kelasC, decoration: const InputDecoration(labelText: "Kelas")),
            TextField(controller: asalC, decoration: const InputDecoration(labelText: "Asal")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final db = await DbHelper.instance.database;
                await db.insert('santri', {'nama': namaC.text, 'kelas': kelasC.text, 'asal': asalC.text});
                _refreshData();
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
