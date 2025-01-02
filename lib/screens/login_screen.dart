import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form Key to manage the form state
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers to get the values of email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Proceed with login logic (e.g., API call)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging In')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          BackgroundImage(),
          // Form layout and content
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

// Widget for background image
class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/Welcome Screen.png', // Replace with the actual image path
      fit: BoxFit.cover, // Image stretches to fit the screen
    );
  }
}

// Widget for the login form
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
          // Sign In Text
          _buildTextSignIn(),
          SizedBox(height: 30), // Space between text and fields

          // Email field
          _buildEmailField(),
          SizedBox(height: 10), // Space between fields

          // Password field
          _buildPasswordField(),
          SizedBox(height: 30), // Space between fields and button

          // Sign In button
          _buildSignInButton(),

          // Optional: Add "Sign Up" or "Create Account" button
          SizedBox(height: 15), // Space between buttons
          _buildSignUpRedirect(context), // Pass context to SignUp redirect
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

  // Widget to build the email input field
  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      style: TextStyle(color: Colors.white), // Set text color
      decoration: InputDecoration(
        hintText: 'Email/Username',
        filled: false,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black), // Set label color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.grey, width: 15), // Border color and width
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email';
        }
        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  // Widget to build the password input field
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

  // Widget to build the Sign In button
  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: onSubmit,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 54),
        backgroundColor: Colors.white,
      ),
      child: Text(
        'Sign In', // Text for the button
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  // Optional: Widget to build the "Sign Up" or "Create Account" redirect
  Widget _buildSignUpRedirect(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the navigation to sign up screen here
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Redirecting to Sign Up')));
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
