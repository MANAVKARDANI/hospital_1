import 'package:hospital_1/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// Import the detail page

// class AppointmentApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AppointmentScreen(),
//     );
//   }
// }

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDay = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 14, minute: 0);
  int _selectedReminder = 25;

  int _currentIndex = 1; // Default to Appointments screen

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              _buildCalendar(screenHeight),
              SizedBox(height: screenHeight * 0.02),
              _buildAvailableTimes(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildReminderOptions(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildConfirmButton(screenWidth),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index
          });
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 1:
              // Stay on the current Appointment screen
              break;
            case 2:
              // Navigate to Dashboard screen (create this screen)
              break;
            case 3:
              // Navigate to Settings screen (create this screen)
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 25),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps, size: 25),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 25),
            label: 'Settings',
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }

  Widget _buildCalendar(double screenHeight) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _selectedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
        });
      },
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        todayDecoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: Colors.teal,
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildAvailableTimes(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Available Time',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: screenWidth * 0.02),
        Wrap(
          spacing: screenWidth * 0.02,
          runSpacing: screenWidth * 0.02,
          children: _buildTimeOptions(screenWidth),
        ),
      ],
    );
  }

  List<Widget> _buildTimeOptions(double screenWidth) {
    final times = [
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 12, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
      const TimeOfDay(hour: 16, minute: 0),
    ];

    return times.map((time) {
      final isSelected = time == _selectedTime;
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedTime = time;
          });
        },
        child: Container(
          width: screenWidth * 0.28,
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal : Colors.teal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.teal : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              time.format(context),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildReminderOptions(double screenWidth) {
    final reminders = [10, 25, 30, 35, 40];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Reminder Me Before',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: screenWidth * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: reminders.map((minutes) {
            final isSelected = minutes == _selectedReminder;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedReminder = minutes;
                });
              },
              child: Container(
                width: screenWidth * 0.15,
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
                decoration: BoxDecoration(
                  color:
                      isSelected ? Colors.teal : Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$minutes Min',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(double screenWidth) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Handle confirmation action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(screenWidth * 0.4, screenWidth * 0.12),
        ),
        child: const Text('Confirm', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
