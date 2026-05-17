import 'package:flutter/material.dart';
import 'halaman_dashboard.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(),
    ));

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B5E20),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mosque, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text("Ahlan Wa Sahlan", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            Text("Sistem Informasi Pondok Pesantren", style: TextStyle(color: Colors.white70)),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.green[900]),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
              child: Text("MASUK KE SISTEM"),
            )
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN SANTRI", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[900])),
            SizedBox(height: 30),
            TextField(decoration: InputDecoration(labelText: "Username / NIS", border: OutlineInputBorder())),
            SizedBox(height: 15),
            TextField(obscureText: true, decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder())),
            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1B5E20)),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HalamanDashboard())),
                child: Text("LOGIN", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
