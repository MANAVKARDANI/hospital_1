import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Check if user is logged in
  Future<void> _checkLoginStatus() async {
    // Simulate a delay for the splash screen (increase to 4 seconds)
    await Future.delayed(const Duration(seconds: 2)); // Changed from 2 to 4 seconds

    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // If user is not logged in, navigate to the LoginScreen
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // If user is logged in, navigate to HomePage
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your logo image here
            Image.asset(
              'assets/Frame.png', // Ensure correct path
              height: 100, // Adjust the height as needed
              fit: BoxFit.contain, // Maintain aspect ratio
            ),
            const SizedBox(height: 20), // Space between logo and loading indicator
            const CircularProgressIndicator(), // Show a loading indicator
          ],
        ),
      ),
    );
  }
}
