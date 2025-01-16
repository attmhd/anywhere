import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../widgets/login_form.dart';
import '../widgets/background_image.dart';
import '../widgets/custom_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  void _showAlert({
    required String title,
    required String message,
    required IconData icon,
    required Color iconColor,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    showCustomAlert(
      context: context,
      title: title,
      message: message,
      icon: icon,
      iconColor: iconColor,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }

  Future<Map<String, dynamic>?> _authenticateUser(String email) async {
    return await Supabase.instance.client
        .from('user')
        .select()
        .eq('email', email)
        .limit(1)
        .single();
  }

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response = await _authenticateUser(email);

      if (response == null) {
        _showAlert(
          title: "Error",
          message: "Email not found",
          icon: Icons.error,
          iconColor: Colors.red,
        );
        return;
      }

      final hashedPassword = _hashPassword(password);

      if (response['password'] == hashedPassword) {
        _showAlert(
          title: "Success",
          message: "Sign In Successful!",
          icon: Icons.check_circle,
          iconColor: Colors.green,
          buttonText: "OK",
          onPressed: () => Navigator.pushNamed(context, '/home'),
        );
      } else {
        _showAlert(
          title: "Error",
          message: "Incorrect password",
          icon: Icons.error,
          iconColor: Colors.red,
        );
      }
    } catch (error) {
      _showAlert(
        title: "Error",
        message: "Login failed: Email not found",
        icon: Icons.warning,
        iconColor: Colors.orange,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackgroundImage(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: LoginForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                onSubmit: _submitForm,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
