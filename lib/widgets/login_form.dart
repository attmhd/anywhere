import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  const LoginForm({
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
          SizedBox(height: 220),
          _buildTextSignIn(),
          SizedBox(height: 30),
          _buildEmailField(),
          SizedBox(height: 10),
          _buildPasswordField(),
          SizedBox(height: 30),
          _buildSignInButton(),
          SizedBox(height: 15),
          _buildSignUpRedirect(context),
        ],
      ),
    );
  }

  Widget _buildTextSignIn() {
    return Text(
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
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Email',
        filled: false,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.grey, width: 15),
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
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
      decoration: InputDecoration(
        hintText: 'Password',
        filled: false,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 15),
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
        minimumSize: Size(double.infinity, 54),
        backgroundColor: Colors.white,
      ),
      child: Text(
        'Sign In',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  Widget _buildSignUpRedirect(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Redirecting to Sign Up')));
      },
      child: Text(
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
