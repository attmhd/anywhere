import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/widgets/register_form.dart';  // Correct import

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
      // Get data from form
      final name = _nameController.text;
      final username = _usernameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;
      final address = _addressController.text;
      final password = _passwordController.text;

      
        // Send data to Supabase
      await Supabase.instance.client
            .from('user') // Change to your table name
            .insert([
              {
                'fullname': name,
                'username': username,
                'email': email,
                'phone': phone,
                'address': address,
                'password': password,
                'gender': _selectedGender,
              }
            ]);
          
        // Show success message with AlertDialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Sign up successful!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );


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
                      borderRadius: BorderRadius.circular(8),
                    ),
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
