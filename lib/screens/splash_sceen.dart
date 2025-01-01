import 'package:flutter/material.dart';
import 'login_screen.dart'; // Ganti dengan halaman tujuan setelah splash screen selesai

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Memanggil fungsi async yang menunggu 5 detik dan kemudian navigasi ke halaman login
    _navigateToLogin();
  }

  // Fungsi asynchronous untuk menunggu dan berpindah ke halaman login
  Future<void> _navigateToLogin() async {
    // Menunggu 5 detik
    await Future.delayed(Duration(seconds: 3));
    // Berpindah ke halaman login setelah delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash.png', // Menggunakan Image.asset untuk menampilkan gambar
          fit: BoxFit.cover, // Menyesuaikan gambar dengan ukuran layar
          width: double.infinity, // Memastikan gambar memenuhi lebar layar
          height: double.infinity, // Memastikan gambar memenuhi tinggi layar
        ),
      ),
    );
  }
}
