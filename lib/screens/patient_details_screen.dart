import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  // Initial patient data (this can be fetched from a backend API)
  String patientName = "Jane Doe";
  String patientAge = "28";
  String patientGender = "Female";
  String patientBloodType = "O+";
  String patientPhone = "+9876543210";
  String patientAddress = "123 Healthcare Street, City";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Icon
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.teal,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Patient Name Field
              _buildTextField('Patient Name', patientName, (value) {
                setState(() {
                  patientName = value;
                });
              }),
              const SizedBox(height: 20),

              // Patient Age Field
              _buildTextField('Age', patientAge, (value) {
                setState(() {
                  patientAge = value;
                });
              }),
              const SizedBox(height: 20),

              // Patient Gender Field
              _buildTextField('Gender', patientGender, (value) {
                setState(() {
                  patientGender = value;
                });
              }),
              const SizedBox(height: 20),

              // Patient Blood Type Field
              _buildTextField('Blood Type', patientBloodType, (value) {
                setState(() {
                  patientBloodType = value;
                });
              }),
              const SizedBox(height: 20),

              // Patient Phone Field
              _buildTextField('Phone Number', patientPhone, (value) {
                setState(() {
                  patientPhone = value;
                });
              }),
              const SizedBox(height: 20),

              // Patient Address Field
              _buildTextField('Address', patientAddress, (value) {
                setState(() {
                  patientAddress = value;
                });
              }),
              const SizedBox(height: 30),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // Logic to save the updated patient details (e.g., send to server)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Patient details updated successfully!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField(
      String label, String initialValue, Function(String) onChanged) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
