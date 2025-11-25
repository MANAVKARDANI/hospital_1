import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instance of FirebaseAuth

  // Validate email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Function to send password reset email with Firebase exception handling
  Future<void> _sendPasswordResetEmail() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        // Log the email address being processed
        print('Attempting to send password reset email to: ${_emailController.text}');

        // Attempt to send a password reset email
        await _auth.sendPasswordResetEmail(email: _emailController.text);
        
        // Notify the user that the email has been sent
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('If an account with that email exists, a password reset email has been sent.'),
        ));
        
        // Optionally, navigate back or to another screen
        Navigator.pop(context); // Go back to the previous screen after sending the email
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // Notify user if no account is found for the provided email
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('No user found with this email address.'),
          ));
        } else {
          // Show other errors
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${e.message}'),
          ));
        }
      } catch (e) {
        // Handle general errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/Frame.png', // Replace with your logo path
              height: 100,
            ),
            const SizedBox(height: 16.0),

            // App Title
            const Text(
              'DocBook',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32.0),

            // Forgot Password Container
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Forgot Password Title
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Instruction Text
                    const Text(
                      'Enter your email for the verification process. We will send a password reset email.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Email Input Field
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 24.0),

                    // Continue Button
                    ElevatedButton(
                      onPressed: _sendPasswordResetEmail, // Call the reset email function directly
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
                          'Continue',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
