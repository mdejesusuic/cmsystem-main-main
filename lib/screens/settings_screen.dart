import 'package:cmsystem/screens/forms/counselingform_consent.dart';
import 'package:flutter/material.dart';
import 'package:cmsystem/screens/home_screen.dart';
import 'package:cmsystem/screens/notification/notification_screen.dart';
import 'package:cmsystem/screens/schedule_screen.dart';
import 'package:cmsystem/screens/login.dart';
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, File? profileImage});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFFDF5F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 16), // Adjusted margins
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Section
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.pink.shade100,
                    radius: 25,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12), // Adjusted spacing
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back !',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'User Name',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30), // Adjusted spacing

              // Settings Title
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF660033),
                ),
              ),
              const SizedBox(height: 24), // Adjusted spacing

              // Account Section
              const Text(
                "Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),

              // Support Section
              const Text(
                "Support",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _buildSettingsItem("Help center"),
              _buildSettingsItem("App feedback"),
              const Spacer(),

              // Logout Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false, // This removes all previous routes
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 16),
                    backgroundColor: Colors.pink.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Adjusted spacing
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Settings is index 4
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CounselingFormConsent()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScheduleScreen()),
              );
              break;
            case 4:
              // Stay on Settings page
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 40), // Plus Button
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: const Icon(Icons.arrow_outward),
      onTap: () {
        // Add logic for other settings items if needed
      },
    );
  }
}
