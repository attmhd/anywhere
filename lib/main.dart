import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/screens/sign_in.dart';
import 'package:myapp/screens/sign_up.dart';
import 'package:myapp/screens/welcome.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/screens/splash_sceen.dart';

Future<void> main() async {
  await initializeApp();
}

class AppRoutes {
  static const String splash = '/';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String welcome = '/welcome';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => SplashScreen(),
        signIn: (context) => LoginScreen(),
        signUp: (context) => SignUpScreen(),
        welcome: (context) => WelcomeScreen(),
      };
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await _loadEnvironmentVariables();
    await _initializeSupabase();
    runApp(MyApp());
  } catch (e) {
    print('Initialization error: $e');
    runApp(ErrorApp(message: e.toString()));
  }
}

Future<void> _loadEnvironmentVariables() async {
  await dotenv.load(fileName: ".env");
  if (dotenv.env['SUPABASE_URL'] == null || dotenv.env['SUPABASE_ANON_KEY'] == null) {
    throw 'Missing Supabase credentials in .env file!';
  }
}

Future<void> _initializeSupabase() async {
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String message;

  const ErrorApp({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 20, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
