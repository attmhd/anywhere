import 'package:flutter/material.dart';
import 'package:myapp/widgets/register_form.dart'; 

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

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signing Up')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign Up', style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
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
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                  child: Text('SUBMIT', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
