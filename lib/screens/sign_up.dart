import 'package:flutter/material.dart';
import 'package:myapp/widgets/custom_alert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/widgets/register_form.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _selectedGender;

  // Method to send data to Supabase
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final username = _usernameController.text.trim();
      final email = _emailController.text.trim();
      final phone = _phoneController.text.trim();
      final address = _addressController.text.trim();
      final password = _passwordController.text.trim();

      if (_selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a gender')),
        );
        return;
      }

      // Hash password dengan SHA-256
      var bytes = utf8.encode(password);
      var hashedPassword = sha256.convert(bytes).toString();

      try {
        await Supabase.instance.client.from('user').insert({
            'fullname': name,
            'username': username,
            'email': email,
            'phone': phone,
            'address': address,
            'password': hashedPassword,
            'gender': _selectedGender,
        });

        if (mounted) {
          showCustomAlert(
            context: context,
            title: "Succes", 
            message: "Sign up successful!",
            icon: Icons.check_circle,
            iconColor: Colors.green,
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        }
      } catch (error) {
        if (mounted) {

          showCustomAlert(
            context: context,
            title: "Error",
            message: "Sign up failed: ${error.toString()}",
            icon: Icons.error,
            iconColor: Colors.red,
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 34),
                  buildNameField(_nameController),
                  SizedBox(height: 24),
                  buildUsernameField(_usernameController),
                  SizedBox(height: 24),
                  buildEmailField(_emailController),
                  SizedBox(height: 24),
                  buildPhoneField(_phoneController),
                  SizedBox(height: 24),
                  buildGenderField(_selectedGender, (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  }),
                  SizedBox(height: 24),
                  buildAddressField(_addressController),
                  SizedBox(height: 24),
                  buildPasswordField(_passwordController),
                  SizedBox(height: 24),
                  buildConfirmPasswordField(_confirmPasswordController, _passwordController),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 54),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20), // Tambahkan padding agar tidak terlalu bawah
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
