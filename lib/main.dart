import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cmsystem/screens/notification/notification_service.dart';
import 'firebase_options.dart';
import 'package:cmsystem/screens/launch_screen.dart';
import 'package:cmsystem/screens/home_screen.dart';
import 'package:cmsystem/screens/schedule_screen.dart';
import 'package:cmsystem/screens/history_screen.dart';
import 'package:cmsystem/screens/settings_screen.dart';
import 'package:cmsystem/screens/notification/notification_screen.dart';
import 'package:cmsystem/screens/forms/counselingform_consent.dart';

// Define a global navigator key for accessing navigation from outside of context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize notification service
  await NotificationService.initialize(navigatorKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Add navigator key
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch',
      routes: {
        '/launch': (context) => const LaunchScreen(),
        '/home': (context) => const MainScreen(initialIndex: 0),
        '/notifications': (context) => const MainScreen(initialIndex: 1),
        '/schedule': (context) => const MainScreen(initialIndex: 3),
        '/history': (context) => const HistoryScreen(),
        '/settings': (context) => const MainScreen(initialIndex: 4),
        '/counseling_form': (context) => const CounselingFormConsent(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;
  int notificationCount = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationScreen(), // Or your updated NotificationScreen
    const Placeholder(), // Placeholder for + button
    const ScheduleScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    // Start listening for notifications when user is logged in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        NotificationService.startListening();
      }
    });

    // Listen for notification count changes
    NotificationService.notificationCountStream.listen((count) {
      setState(() {
        notificationCount = count;
      });
    });

    // Load notification count
    _loadNotificationCount();
  }

  Future<void> _loadNotificationCount() async {
    final count = await NotificationService.getUnreadCount();
    setState(() {
      notificationCount = count;
    });
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // Navigate to Counseling Form when clicking the + button
      Navigator.pushNamed(context, '/counseling_form');
    } else {
      setState(() {
        _selectedIndex = index;

        // If navigating to notifications tab, mark all as read
        if (index == 1) {
          NotificationService.markAllAsRead();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.notifications),
                if (notificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        notificationCount > 9 ? '9+' : '$notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Notif',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, size: 40, color: Colors.pink),
              label: ''),
          const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Schedule'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
