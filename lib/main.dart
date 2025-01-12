import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/screens/splash_sceen.dart'; // Sesuaikan path jika perlu

void main() async {
  // Pastikan WidgetsBinding sudah terinisialisasi sebelum melakukan operasi lainnya
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env variables with error handling
  try {
    await dotenv.load(fileName: ".env");
    print(".env file loaded successfully");
  } catch (e) {
    print("Error loading .env file: $e");
    runApp(MyAppWithError(message: "Error loading .env file!"));  // Show an error screen if .env fails to load
    return;  // Stop execution if .env fails to load
  }

  // Ambil URL dan anonKey dari file .env
  String? supabaseUrl = dotenv.env['SUPABASE_URL'];
  String? supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  // Pastikan URL dan anonKey tidak null
  if (supabaseUrl == null || supabaseAnonKey == null) {
    print('Missing Supabase credentials in .env file!');
    runApp(MyAppWithError(message: "Missing Supabase credentials!"));
    return; // Stop execution if credentials are missing
  }

  // Inisialisasi Supabase dengan URL dan anon key dari file .env
  try {
    await Supabase.initialize(
      url: supabaseUrl,  // Mengambil URL dari file .env
      anonKey: supabaseAnonKey,  // Mengambil anon key dari file .env
    );
    print("Supabase initialized successfully");
  } catch (e) {
    print("Error initializing Supabase: $e");
    runApp(MyAppWithError(message: "Error initializing Supabase!"));  // Show an error screen if Supabase fails to initialize
    return;  // Stop execution if Supabase initialization fails
  }

  // Jalankan aplikasi setelah Supabase diinisialisasi
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: SplashScreen(),  // Mengarah ke SplashScreen atau screen awal
    );
  }
}

// Custom error screen widget
class MyAppWithError extends StatelessWidget {
  final String message;

  MyAppWithError({required this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 20, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
