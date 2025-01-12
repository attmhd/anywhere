import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../widgets/login_form.dart';
import '../widgets/background_image.dart';
import '../widgets/custom_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        final response = await Supabase.instance.client
            .from('user')
            .select()
            .eq('email', email)
            .limit(1)
            .single();

        if (response == null) {
          showCustomAlert(
            context: context,
            title: "Error",
            message: "Email not found",
            icon: Icons.error,
            iconColor: Colors.red,
          );
          return;
        }

        var bytes = utf8.encode(password);
        var hashedPassword = sha256.convert(bytes).toString();

        if (response['password'] == hashedPassword) {
          showCustomAlert(
            context: context,
            title: "Success",
            message: "Sign In Successful!",
            icon: Icons.check_circle,
            iconColor: Colors.green,
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        } else {
          showCustomAlert(
            context: context,
            title: "Error",
            message: "Incorrect password",
            icon: Icons.error,
            iconColor: Colors.red,
          );
        }
      } catch (error) {
        showCustomAlert(
          context: context,
          title: "Error",
          message: "Login failed: Email not found",
          icon: Icons.warning,
          iconColor: Colors.orange,
        );
      }
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
