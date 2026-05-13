import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'db_helper.dart';

class HalamanKeuangan extends StatefulWidget {
  const HalamanKeuangan({super.key});
  @override
  State<HalamanKeuangan> createState() => _HalamanKeuanganState();
}

class _HalamanKeuanganState extends State<HalamanKeuangan> {
  List<Map<String, dynamic>> _transaksi = [];
  double _saldo = 0;

  void _refreshKeuangan() async {
    final db = await DbHelper.instance.database;
    final res = await db.query('keuangan');
    double tempSaldo = 0;
    for (var item in res) {
      if (item['jenis'] == 'Pemasukan') tempSaldo += (item['jumlah'] as num).toDouble();
      else tempSaldo -= (item['jumlah'] as num).toDouble();
    }
    setState(() { _transaksi = res; _saldo = tempSaldo; });
  }

  @override
  void initState() { super.initState(); _refreshKeuangan(); }

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return Scaffold(
      appBar: AppBar(title: const Text("Keuangan Pondok")),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text("Total Saldo", style: TextStyle(color: Colors.white70)),
                Text(fmt.format(_saldo), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Text("Riwayat Transaksi", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _transaksi.length,
              itemBuilder: (context, i) => ListTile(
                leading: Icon(_transaksi[i]['jenis'] == 'Pemasukan' ? Icons.add_circle : Icons.remove_circle, color: _transaksi[i]['jenis'] == 'Pemasukan' ? Colors.green : Colors.red),
                title: Text(_transaksi[i]['keterangan']),
                trailing: Text(fmt.format(_transaksi[i]['jumlah'])),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showFinanceForm,
        label: const Text("Catat"),
        icon: const Icon(Icons.edit),
      ),
    );
  }

  void _showFinanceForm() {
    final ketC = TextEditingController();
    final jmlC = TextEditingController();
    String jenis = 'Pemasukan';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah Catatan"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              value: jenis,
              items: ['Pemasukan', 'Pengeluaran'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => jenis = v!,
            ),
            TextField(controller: ketC, decoration: const InputDecoration(labelText: "Keterangan")),
            TextField(controller: jmlC, decoration: const InputDecoration(labelText: "Jumlah (Rp)"), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          ElevatedButton(onPressed: () async {
            final db = await DbHelper.instance.database;
            await db.insert('keuangan', {
              'jenis': jenis, 'keterangan': ketC.text,
              'jumlah': double.parse(jmlC.text),
              'tanggal': DateTime.now().toString()
            });
            _refreshKeuangan();
            Navigator.pop(context);
          }, child: const Text("Simpan"))
        ],
      ),
    );
  }
}
