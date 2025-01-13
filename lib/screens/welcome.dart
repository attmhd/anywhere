import 'package:flutter/material.dart';
import 'package:myapp/screens/sign_in.dart';
import 'package:myapp/screens/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Image.asset(
      'images/Welcome Screen.png',
      fit: BoxFit.cover,
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 430),
        _buildTextSection(),
        const SizedBox(height: 30),
        _buildButtonsSection(),
      ],
    );
  }

  Widget _buildTextSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Everywhere\nPark reservations',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Makes it easier to find the right parking\nspace for your vehicle',
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            text: 'Sign In',
            onPressed: (context) => Navigator.pushNamed(context, '/signIn'),
          ),
          const SizedBox(height: 10),
          _buildButton(
            text: 'Sign Up',
            onPressed: (context) => Navigator.pushNamed(context, '/signUp'),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Function(BuildContext) onPressed,
  }) {
    return SizedBox(
      width: 319,
      height: 54,
      child: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () => onPressed(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
