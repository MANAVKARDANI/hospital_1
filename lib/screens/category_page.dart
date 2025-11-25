import 'package:hospital_1/screens/bottom_bar_widget.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Doctors'),
        backgroundColor: Colors.teal,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCategoryCard(context, 'Body', Icons.person),
          _buildCategoryCard(context, 'Ear', Icons.hearing),
          _buildCategoryCard(context, 'Liver', Icons.local_drink),
          _buildCategoryCard(context, 'Lungs', Icons.air),
          _buildCategoryCard(context, 'Brain', Icons.psychology),
          _buildCategoryCard(context, 'Heart', Icons.favorite),
        ],
      ),
      bottomNavigationBar: const BottomBarWidget(currentIndex: 2),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryDetailPage(categoryName: title)),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Example of a detail page for each category
class CategoryDetailPage extends StatelessWidget {
  final String categoryName;

  const CategoryDetailPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Doctors'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Doctors related to $categoryName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
