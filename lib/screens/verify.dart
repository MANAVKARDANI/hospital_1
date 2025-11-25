import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _checkEmailVerification(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error: Could not verify email.');
            } else {
              return const Text(
                'Email verified successfully! You can now log in.',
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _checkEmailVerification() async {
    // Get the URL and extract the code (replace this link with real deep link)
    Uri uri = Uri.parse(
      'https://batch-a-project.firebaseapp.com/__/auth/action?mode=action&oobCode=code',
    );
    String? oobCode = uri.queryParameters['oobCode'];

    if (oobCode != null) {
      try {
        await FirebaseAuth.instance.applyActionCode(oobCode);
      } catch (e) {
        throw Exception('Error verifying email: $e');
      }
    } else {
      throw Exception('No action code found in the URL');
    }
  }
}
