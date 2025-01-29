import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/user_provider.dart'; // Import UserProvider
import 'package:myapp/widgets/bottom_navigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch the user data from UserProvider
    final user = Provider.of<UserProvider>(context).user;

    // Default values if user data is null
    final String userName = user?['fullname'] ?? 'Guest';
    final String userEmail = user?['email'] ?? 'example@domain.com';
    final String userPhone = user?['phone'] ?? '+62 81345543';

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(userName, userEmail, userPhone),  // Pass user data to header
            const SizedBox(height: 20),
            _buildSettingsList(context),
            const SizedBox(height: 20),
            const BottomNavBar(),
          ],
        ),
      ),
    );
  }

  // Updated Header to reflect dynamic user data
  Widget _buildHeader(String userName, String userEmail, String userPhone) {
    return Stack(
      children: [
        Container(
          height: 240,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            image: DecorationImage(
              image: AssetImage('images/parking.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('andrew.jpg'),
              ),
              const SizedBox(height: 10),
              Text(
                userName,  // Display dynamic user name
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '$userEmail | $userPhone',  // Display dynamic email and phone number
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.edit,
            title: 'Edit profile information',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.notifications,
            title: 'Notifications',
            trailing: const Text(
              'ON',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.language,
            title: 'Language',
            trailing: const Text(
              'English',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.security,
            title: 'Security',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.brightness_6,
            title: 'Theme',
            trailing: const Text(
              'Light mode',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.contact_mail,
            title: 'Contact us',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.arrow_back,
            title: 'Sign out',
            onTap: () {
              Navigator.pushNamed(context, '/signIn');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        tileColor: Colors.white,
        leading: Icon(
          icon,
          size: 30,
          color: Colors.black,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing ?? const SizedBox.shrink(),
        onTap: onTap,
      ),
    );
  }
}
