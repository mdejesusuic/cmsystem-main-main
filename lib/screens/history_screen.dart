import 'package:flutter/material.dart';
import 'package:cmsystem/screens/home_screen.dart';
import 'package:cmsystem/screens/notification/notification_screen.dart';
import 'package:cmsystem/screens/forms/counselingform_consent.dart';
import 'package:cmsystem/screens/schedule_screen.dart';
import 'package:cmsystem/screens/settings_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: _buildAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildSemesterDropdown(),
          const SizedBox(height: 10),
          Expanded(
            child: _buildSessionList(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      // backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        "Counseling Session History",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF660033),
        ),
      ),
    );
  }

  Widget _buildSemesterDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: "Semester 2023-2024",
            items: const [
              DropdownMenuItem(
                  value: "Semester 2023-2024",
                  child: Text("Semester 2023-2024")),
              DropdownMenuItem(
                  value: "Semester 2022-2023",
                  child: Text("Semester 2022-2023")),
            ],
            onChanged: (value) {},
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: [
        _buildSessionCard("Counselor Jane", "September 27, 2024", "9:00 AM"),
        _buildSessionCard("Counselor Jane", "October 4, 2024", "10:00 AM"),
        _buildSessionCard("Counselor Jane", "October 10, 2024", "2:00 PM"),
      ],
    );
  }

  Widget _buildSessionCard(String counselor, String date, String time) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(250, 247, 242, 250),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(counselor,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Date: $date",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              Text("Time: $time",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // backgroundColor: Colors.white,
      selectedItemColor: Colors.pink.shade700,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: "Notif"),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle, size: 40, color: Colors.pink),
          label: "",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: "Schedule"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
            break;
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()));
            break;
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CounselingFormConsent()));
            break;
          case 3:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScheduleScreen()));
            break;
          case 4:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SettingsScreen()));
            break;
        }
      },
    );
  }
}
