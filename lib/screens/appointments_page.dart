import 'package:hospital_1/screens/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
// Import the HomePage

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildAppointmentCard(
              'Dr. Anubhav (Dermatologist)',
              'Aug 25, 2024',
              '2:00 PM',
            ),
            _buildAppointmentCard(
              'Dr. Shreya (Cardiologist)',
              'Aug 25, 2024',
              '2:00 PM',
            ),
            _buildAppointmentCard(
              'Dr. Meenakshi (Gynaecologist)',
              'Aug 25, 2024',
              '2:00 PM',
            ),
            _buildAppointmentCard(
              'Dr. Yash (Orthopedic)',
              'Aug 25, 2024',
              '2:00 PM',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(currentIndex: 1),
    );
  }

  // Helper method to build appointment cards
  Widget _buildAppointmentCard(String doctor, String date, String time) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(doctor, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Date: $date\nTime: $time'),
      ),
    );
  }
}
