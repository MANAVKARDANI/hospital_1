import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _reenterPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Validate re-entered password
  String? _validateReenterPassword(String? value) {
    if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Function to reset password
  Future<void> _resetPassword() async {
    try {
      // Get the current user
      User? user = _auth.currentUser;

      // Update the user's password
      await user?.updatePassword(_newPasswordController.text);

      // Notify the user
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password reset successfully.'),
      ));

      // Redirect to login page
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Handle error if password update fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to reset password: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: true, // This enables the back button
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),

            // Instruction Text
            const Text(
              'Set the new password for your account so you can log in and access all the features.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),

            // Password Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // New Password Field
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 16.0),

                  // Re-enter Password Field
                  TextFormField(
                    controller: _reenterPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Re-enter Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateReenterPassword,
                  ),
                  const SizedBox(height: 24.0),

                  // Reset Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        _resetPassword(); // Call the reset password function
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
