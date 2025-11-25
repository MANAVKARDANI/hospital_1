import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? email;
  String? password;
  bool isPasswordVisible = false;
  bool isTermsAccepted = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Email Validation
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

  // Password Validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Name Validation
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  // Form Submission
  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (!isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must accept the terms and conditions')),
      );
      return;
    }

    _formKey.currentState?.save();

    try {
      // Create user with Firebase Authentication
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      final uid = userCredential.user!.uid;

      // Save user info in Firestore
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'signupTime': FieldValue.serverTimestamp(),
      });

      // Simple email verification (uses Firebase default settings)
      await userCredential.user!.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Account created! Verification email sent. Please check your inbox.',
          ),
        ),
      );

      // Go to login screen
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      // Log the exact error in the debug console
      debugPrint('FirebaseAuthException: ${e.code} - ${e.message}');

      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format.';
          break;
        case 'weak-password':
          errorMessage = 'Weak password. Please use a stronger one.';
          break;
        case 'operation-not-allowed':
          errorMessage =
              'Email/password sign-in is disabled in Firebase. Enable it in Firebase Console.';
          break;
        default:
          errorMessage = 'Sign Up Failed: ${e.message ?? 'Unknown error'}';
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e, stack) {
      // Any other error (Firestore, etc.)
      debugPrint('Unexpected sign up error: $e');
      debugPrint(stack.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/Frame.png'),
                height: 100,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'DocBook',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32.0),

              // Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: _validateName,
                onSaved: (value) => name = value,
              ),
              const SizedBox(height: 16.0),

              // Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
                onSaved: (value) => email = value,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),

              // Password
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !isPasswordVisible,
                validator: _validatePassword,
                onSaved: (value) => password = value,
              ),
              const SizedBox(height: 16.0),

              // Terms checkbox
              Row(
                children: [
                  Checkbox(
                    value: isTermsAccepted,
                    onChanged: (value) {
                      setState(() {
                        isTermsAccepted = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I agree with the Terms of Service & Privacy Policy',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Sign up button
              ElevatedButton(
                onPressed: _submitForm,
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
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(height: 16.0),

              // Go to login
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Have an account? Log in',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
