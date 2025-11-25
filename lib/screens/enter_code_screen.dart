import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize Firebase Auth

  // Controllers for each digit
  final _digit1Controller = TextEditingController();
  final _digit2Controller = TextEditingController();
  final _digit3Controller = TextEditingController();
  final _digit4Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Validate if all fields are filled with exactly 1 digit
  String? _validateCode() {
    if (_digit1Controller.text.isEmpty ||
        _digit2Controller.text.isEmpty ||
        _digit3Controller.text.isEmpty ||
        _digit4Controller.text.isEmpty) {
      return 'All digits are required';
    }
    return null;
  }

  // Function to verify the entered code
  Future<void> _verifyCode() async {
    String code = _digit1Controller.text +
        _digit2Controller.text +
        _digit3Controller.text +
        _digit4Controller.text;

    // Ideally, you should verify the code received via email here.
    // For now, we will simulate a successful verification for demonstration.
    // Replace the following line with your actual verification logic.
    bool isCodeValid = await _verifyEmailCode(code);

    if (isCodeValid) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Code verified successfully.'),
      ));

      // Navigate to the ResetPasswordScreen
      Navigator.pushNamed(context, '/reset-password');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid code. Please try again.'),
      ));
    }
  }

  // Simulate code verification logic
  Future<bool> _verifyEmailCode(String code) async {
    // TODO: Implement your actual code verification logic here
    // This is just a placeholder for demonstration purposes
    return Future.delayed(const Duration(seconds: 1), () => code == "1234");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter 4-Digit Code'),
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
            // App Title
            const Text(
              'Enter 4-Digit Code',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32.0),

            // Instruction Text
            const Text(
              'Enter the 4-digit code that you received on your email.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),

            // 4-Digit Code Input Fields in Squares
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDigitTextField(_digit1Controller),
                  _buildDigitTextField(_digit2Controller),
                  _buildDigitTextField(_digit3Controller),
                  _buildDigitTextField(_digit4Controller),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Verify Button
            ElevatedButton(
              onPressed: () {
                if (_validateCode() == null) {
                  _verifyCode(); // Call the verify function
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(_validateCode() ?? ''),
                  ));
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
                  'Verify',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a square TextFormField for each digit
  Widget _buildDigitTextField(TextEditingController controller) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1, // Only allow one character per box
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus(); // Move to next input
          }
        },
      ),
    );
  }
}
