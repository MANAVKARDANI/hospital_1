import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_1/screens/bottom_bar_widget.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading appointments"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text("No Appointments Found"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Doctor: ${data['doctorName'] ?? ''}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Specialization: ${data['specialization'] ?? ''}",
                          style: const TextStyle(fontSize: 14)),
                      const Divider(),

                      Text("Patient Name: ${data['patientName'] ?? ''}",
                          style: const TextStyle(fontSize: 14)),
                      Text("Age: ${data['age'] ?? ''}",
                          style: const TextStyle(fontSize: 14)),
                      Text("Gender: ${data['gender'] ?? ''}",
                          style: const TextStyle(fontSize: 14)),
                      Text("Mobile: ${data['mobile'] ?? ''}",
                          style: const TextStyle(fontSize: 14)),
                      Text("Email: ${data['email'] ?? ''}",
                          style: const TextStyle(fontSize: 14)),
                      const Divider(),

                      Text("Appointment Date: ${data['appointmentDate'] ?? 'Not selected'}",
                          style: const TextStyle(fontSize: 14)),
                      Text("Appointment Time: ${data['appointmentTime'] ?? 'Not selected'}",
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Status: ${data['status'] ?? ''}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomBarWidget(currentIndex: 1),
    );
  }
}
