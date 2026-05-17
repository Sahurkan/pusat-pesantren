import 'package:flutter/material.dart';
import 'db_helper.dart';

class HalamanTabungan extends StatefulWidget {
  @override
  _HalamanTabunganState createState() => _HalamanTabunganState();
}

class _HalamanTabunganState extends State<HalamanTabungan> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _riwayat = [];

  @override
  void initState() {
    super.initState();
    _ambilData();
  }

  void _ambilData() async {
    final data = await DbHelper.instance.ambilSemuaData();
    setState(() => _riwayat = data);
  }

  void _simpan() async {
    if (_controller.text.isNotEmpty) {
      await DbHelper.instance.simpanTransaksi("MOH SAHUR", int.parse(_controller.text));
      _controller.clear();
      _ambilData(); // Refresh list
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saldo Berhasil Disimpan!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tabungan Santri"), backgroundColor: Color(0xFF1B5E20)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Masukkan Nominal Top Up (Rp)", border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(onPressed: _simpan, child: Text("Simpan ke Database")),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _riwayat.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.account_balance_wallet, color: Colors.green),
                title: Text("Rp ${_riwayat[index]['saldo']}"),
                subtitle: Text("Tanggal: ${_riwayat[index]['id']}"), // ID sebagai tanda record
              ),
            ),
          )
        ],
      ),
    );
  }
}
