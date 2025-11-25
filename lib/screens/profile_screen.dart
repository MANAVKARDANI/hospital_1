import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String name = "";
  String email = "";
  String phone = ""; // This will remain for input

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the screen initializes
  }

  // Fetch user data from Firestore
  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser; // Get the current user
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore
            .collection('users') // Ensure this matches your Firestore structure
            .doc(user.uid) // Use the user's UID
            .get();

        if (userDoc.exists) {
          setState(() {
            name = userDoc['name'] ?? ''; // Retrieve name
            email = userDoc['email'] ?? ''; // Retrieve email
            // phone = userDoc['phone'] ?? ''; // Optionally set phone only if exists
          });
        }
      }
    } catch (e) {
      // Handle error if fetching data fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  // Update user data in Firestore
  Future<void> _updateUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': name,
          'email': email,
          'phone': phone.isNotEmpty ? phone : FieldValue.delete(), // Only update phone if it's not empty
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );
      }
    } catch (e) {
      // Handle error if updating data fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

  // Function to handle logout
  Future<void> _logout() async {
    try {
      await _auth.signOut(); // Sign out from Firebase
      Navigator.pushReplacementNamed(context, '/login'); // Navigate to login screen
    } catch (e) {
      // Handle error if sign-out fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: $e")),
      );
    }
  }

  // Function to show confirmation dialog before logout
  Future<void> _showLogoutConfirmation() async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
    if (shouldLogout == true) {
      _logout(); // Call logout function
    }
  }

  // Reusable button widget
  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/download1.jpeg'), // Change as needed
              ),
              const SizedBox(height: 20),

              // Name TextField
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value; // Update name value on change
                  });
                },
              ),
              const SizedBox(height: 20),

              // Email TextField
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    email = value; // Update email value on change
                  });
                },
              ),
              const SizedBox(height: 20),

              // Phone TextField
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    phone = value; // Update phone value on change
                  });
                },
              ),
              const SizedBox(height: 30),

              // Save Changes Button
              _buildButton('Save Changes', _updateUserData),
              const SizedBox(height: 20),

              // Logout Button
              _buildButton('Logout', _showLogoutConfirmation),
            ],
          ),
        ),
      ),
    );
  }
}
