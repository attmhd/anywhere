import 'package:flutter/material.dart';
import 'package:myapp/screens/sign_in.dart';
import 'package:myapp/screens/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Ensure Stack fills the entire screen
        children: <Widget>[
          // Background image
          Image.asset(
            'images/Welcome Screen.png', // Image as background
            fit: BoxFit.cover, // Image stretches to fit the screen
          ),
          // Layout for text and buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.start, // Start at the top
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              SizedBox(height: 430),
              // Text section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
              ),
              
              // SizedBox to create space between text and buttons
              SizedBox(height: 30), // Adjust the height as needed

              // Buttons section (Center-aligned)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    // Sign In button
                    Container(
                      width: 319,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Login Screen when 'Sign In' is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Space between buttons

                    // Sign Up button
                    Container(
                      width: 319,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Register Screen when 'Sign Up' is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20, 
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


