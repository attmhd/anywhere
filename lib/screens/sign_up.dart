import 'package:flutter/material.dart';
import 'package:myapp/widgets/custom_alert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/widgets/register_form.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = _SignUpControllers();
  String? _selectedGender;

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_isFormValid()) return;

    try {
      await _saveUserData();
      if (mounted) _showSuccessAlert();
    } catch (error) {
      if (mounted) _showErrorAlert(error.toString());
    }
  }

  bool _isFormValid() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      _showSnackBar('Please fill in all fields');
      return false;
    }
    if (_selectedGender == null) {
      _showSnackBar('Please select a gender');
      return false;
    }
    return true;
  }

  Future<void> _saveUserData() async {
    final userData = {
      'fullname': _controllers.name.text.trim(),
      'username': _controllers.username.text.trim(),
      'email': _controllers.email.text.trim(),
      'phone': _controllers.phone.text.trim(),
      'address': _controllers.address.text.trim(),
      'password': _hashPassword(_controllers.password.text.trim()),
      'gender': _selectedGender,
    };

    await Supabase.instance.client.from('user').insert(userData);
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  void _showSuccessAlert() {
    showCustomAlert(
      context: context,
      title: "Success",
      message: "Sign up successful!",
      icon: Icons.check_circle,
      iconColor: Colors.green,
      buttonText: "OK",
      onPressed: () => Navigator.pushNamed(context, '/signIn'),
    );
  }

  void _showErrorAlert(String error) {
    showCustomAlert(
      context: context,
      title: "Error",
      message: "Sign up failed: $error",
      icon: Icons.error,
      iconColor: Colors.red,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Sign Up',
        style: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pushNamed(context, '/welcome'),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 34),
                _buildFormFields(),
                const SizedBox(height: 24),
                _buildSubmitButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        buildNameField(_controllers.name),
        const SizedBox(height: 24),
        buildUsernameField(_controllers.username),
        const SizedBox(height: 24),
        buildEmailField(_controllers.email),
        const SizedBox(height: 24),
        buildPhoneField(_controllers.phone),
        const SizedBox(height: 24),
        buildGenderField(_selectedGender, (newValue) {
          setState(() => _selectedGender = newValue);
        }),
        const SizedBox(height: 24),
        buildAddressField(_controllers.address),
        const SizedBox(height: 24),
        buildPasswordField(_controllers.password),
        const SizedBox(height: 24),
        buildConfirmPasswordField(_controllers.confirmPassword, _controllers.password),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 54),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'SUBMIT',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class _SignUpControllers {
  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void dispose() {
    name.dispose();
    username.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    password.dispose();
    confirmPassword.dispose();
  }
}
