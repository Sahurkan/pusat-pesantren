import 'package:flutter/material.dart';
import 'db_helper.dart';

class HalamanTabungan extends StatefulWidget {
  @override
  _HalamanTabunganState createState() => _HalamanTabunganState();
}

class _HalamanTabunganState extends State<HalamanTabungan> {
  final _nominalController = TextEditingController();
  List<Map<String, dynamic>> _riwayat = [];

  @override
  void initState() { super.initState(); _muatData(); }
  void _muatData() async {
    final d = await DbHelper.instance.ambilData('tabungan');
    setState(() => _riwayat = d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tabungan Santri"), backgroundColor: Color(0xFF1B5E20)),
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
                    TextField(
                      controller: _nominalController, 
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Masukkan Nominal Top Up (Rp)"),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1B5E20)),
                        onPressed: () async {
                          if (_nominalController.text.isNotEmpty) {
                            await DbHelper.instance.simpanData('tabungan', {
                              'jumlah': int.parse(_nominalController.text),
                              'tanggal': 'Hari Ini'
                            });
                            _nominalController.clear();
                            _muatData();
                          }
                        },
                        child: Text("SIMPAN TABUNGAN", style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Text("RIWAYAT MASUK TABUNGAN:", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _riwayat.length,
              itemBuilder: (context, i) => Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: Colors.green),
                  title: Text("Rp ${_riwayat[i]['jumlah']}"),
                  subtitle: Text("Status Berhasil disimpan"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
