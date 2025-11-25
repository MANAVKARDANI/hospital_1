import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo or Main Image
              const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      'assets/logo.png'), // Replace with your logo image path
                ),
              ),
              const SizedBox(height: 20),

              // App Name
              const Text(
                'DocBook',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),

              // Brief Description
              const Text(
                'Your trusted platform for managing and booking doctor appointments with ease. Our goal is to simplify healthcare access for everyone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),

              // Divider
              const Divider(thickness: 1),

              // Our Mission Section
              _buildSectionTitle('Our Mission', Icons.lightbulb_outline),
              const SizedBox(height: 10),
              const Text(
                'To empower patients by providing them with seamless access to healthcare services and ensuring a smooth and hassle-free experience in booking appointments with top doctors and medical professionals.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),

              // Our Team Section
              _buildSectionTitle('Our Team', Icons.people),
              const SizedBox(height: 10),
              const Text(
                'Our team is made up of dedicated professionals in the healthcare and tech industries, all driven by a shared vision to make healthcare more accessible and convenient for everyone.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),

              // Contact Us Section
              _buildSectionTitle('Contact Us', Icons.mail_outline),
              const SizedBox(height: 10),
              const Text(
                'Have any questions or feedback? Feel free to reach out to us via email at support@docbook.com or call us at +1234567890.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),

              // Footer Section
              const Text(
                '© 2024 DocBook. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Widget for Section Titles with Icons
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }
}
