import 'package:flutter/material.dart';
import 'package:hospital_1/screens/profile_screen.dart';
import 'package:hospital_1/screens/bottom_bar_widget.dart';
import 'doctor_detail_page.dart';
import 'category_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Your Doctor',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                // Navigate to the Profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: const Icon(Icons.person, color: Colors.teal),
              ),
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search.....',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),

            // Category Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryIcon(
                    Icons.local_hospital, Colors.blue, 'Dentist', context),
                _buildCategoryIcon(
                    Icons.favorite, Colors.green, 'Cardiology', context),
                _buildCategoryIcon(
                    Icons.visibility, Colors.orange, 'Eye', context),
                _buildCategoryIcon(
                    Icons.pregnant_woman, Colors.red, 'Gynae', context),
              ],
            ),

            const SizedBox(height: 20),

            // Doctor Cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: [
                  _buildDoctorCard('Dr. Amit', 'Specialist Cardiology',
                      'assets/download1.jpeg', context),
                  _buildDoctorCard('Dr. Shreya', 'Specialist Gynaecologist',
                      'assets/download2.jpeg', context),
                  _buildDoctorCard('Dr. Yash', 'Specialist Orthopedic',
                      'assets/download3.jpeg', context),
                  _buildDoctorCard('Dr. Meenakshi', 'Specialist Dentist',
                      'assets/download4.jpeg', context),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(currentIndex: 0),
    );
  }

  Widget _buildCategoryIcon(
      IconData iconData, Color color, String label, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(categoryName: label),
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(iconData, size: 30, color: color),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String specialization, String imagePath,
      BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailPage(
              doctorName: name,
              specialization: specialization,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    specialization,
                    style: const TextStyle(color: Colors.teal),
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
