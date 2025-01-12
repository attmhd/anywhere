import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/Welcome Screen.png'), // Pastikan gambar ada di folder assets/images
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
