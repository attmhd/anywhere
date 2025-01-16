import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  const LoginForm({super.key, 
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 220),
          _buildTextSignIn(),
          const SizedBox(height: 30),
          _buildEmailField(),
          const SizedBox(height: 10),
          _buildPasswordField(),
          const SizedBox(height: 30),
          _buildSignInButton(),
          const SizedBox(height: 15),
          _buildSignUpRedirect(context),
        ],
      ),
    );
  }

  Widget _buildTextSignIn() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Email',
        filled: false,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(color: Colors.grey, width: 15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email';
        }
        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
            .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
      decoration: InputDecoration(
        hintText: 'Password',
        filled: false,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 15),
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: onSubmit,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 54),
        backgroundColor: Colors.white,
      ),
      child: const Text(
        'Sign In',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

    Widget _buildSignUpRedirect(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigate to the sign-up page (you can replace this with your own sign-up screen)
        Navigator.pushNamed(context, '/signUp'); // Make sure to define '/signUp' in your routes
      },
      child: const Text(
        "Don't have an account? Sign Up",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}