import 'package:hospital_1/screens/AppointmentScreen.dart';
import 'package:hospital_1/screens/bottom_bar_widget.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  final String doctorName;
  final String specialization;
  final String imagePath;

  const BookingPage({super.key, 
    required this.doctorName,
    required this.specialization,
    required this.imagePath,
  });

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final int _currentIndex = 0; // Index for the bottom navigation bar
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _selectedGender = 'Male'; // Default gender selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Book Appointment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display doctor information
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(widget.imagePath),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctorName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.specialization,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Patient's Name
            const Text('Patient\'s Name'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Age Section
            const Text('Age'),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                hintText: 'Enter Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            // Gender Selection
            const Text('Gender'),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value.toString();
                        });
                      },
                    ),
                    const Text('Male'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value.toString();
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Others',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value.toString();
                        });
                      },
                    ),
                    const Text('Others'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Mobile Number
            const Text('Mobile Number'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Email
            const Text('Email'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Booking Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the AppointmentScreen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AppointmentScreen(), // Pass necessary data if required
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Updated to backgroundColor
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(currentIndex: 0),
    );
  }
}
