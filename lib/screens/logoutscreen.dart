import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  // Function to log out
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Firebase logout
      Navigator.pushReplacementNamed(context, '/login'); // Navigate to Login screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout Confirmation'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Are you sure you want to log out?',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Confirm Logout Button
                ElevatedButton(
                  onPressed: () => _logout(context), // Confirm logout
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Logout', style: TextStyle(fontSize: 18)),
                ),
                // Cancel Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the Profile page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Cancel', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
