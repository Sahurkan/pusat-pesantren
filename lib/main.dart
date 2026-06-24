import 'package:flutter/material.dart';
import 'halaman_dashboard.dart'; // Menyambungkan ke halaman dashboard kamu

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pusat Pesantren',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HalamanLogin(),
    );
  }
}

class HalamanLogin extends StatefulWidget {
  @override
  _HalamanLoginState createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _prosesLogin() {
    // Kunci Akun Pengguna: admin & 123456
    if (_usernameController.text == "admin" && _passwordController.text == "123456") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HalamanDashboard()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username atau Password Salah!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.mosque, size: 80, color: Color(0xFF1B5E20)),
                  SizedBox(height: 10),
                  Text(
                    "LOGIN SISTEM PESANTREN",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1B5E20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _prosesLogin,
                      child: Text("MASUK", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
