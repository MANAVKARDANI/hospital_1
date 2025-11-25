// lib/screens/settings_screen.dart

import 'package:hospital_1/screens/bottom_bar_widget.dart';
import 'package:hospital_1/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Import the profile screen
import 'about_us_screen.dart';
import 'patient_details_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key}); // Added const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Navigate to Profile Screen when tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ProfileScreen()), // Ensure const constructor
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ResetPasswordScreen()), // Ensure const constructor
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AboutUsScreen()), // Ensure const constructor
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.medical_services),
            title: const Text('Patient Details'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const PatientDetailsScreen()), // Ensure const constructor
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomBarWidget(currentIndex: 3),
    );
  }
}
