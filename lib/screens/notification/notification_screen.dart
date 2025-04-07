import 'package:cmsystem/screens/forms/counselingform_consent.dart';
import 'package:cmsystem/screens/home_screen.dart';
import 'package:cmsystem/screens/schedule_screen.dart';
import 'package:cmsystem/screens/settings_screen.dart';
import 'package:cmsystem/screens/notification/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String filter = 'All'; // Default filter
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;
  bool isDebugMode = false; // Toggle for showing debug controls

  // Add debug logs variable
  String _debugLogs = '';

  // Add variable for the profile image URL
  String profileImageUrl = '';

  void _log(String message) {
    setState(() {
      _debugLogs = "$message\n$_debugLogs";
    });
    print(message);
  }

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    // Retrieve the profile image from a persistent storage or shared preferences
    _loadProfileImage();
  }

  // Method to load the profile image (simulating a persistent store)
  Future<void> _loadProfileImage() async {
    // Simulating loading the profile image from shared preferences or other storage
    // Here we're assuming it's stored in SharedPreferences or a similar persistent storage.
    String? loadedImageUrl =
        await getProfileImageFromStorage(); // Replace with actual code to fetch the image
    setState(() {
      profileImageUrl = loadedImageUrl ?? '';
    });
  }

  Future<String?> getProfileImageFromStorage() async {
    // Fetch the stored image URL (this is just a placeholder for actual storage retrieval logic)
    return 'https://example.com/your_new_image.jpg'; // Placeholder image URL
  }

  Future<void> _loadNotifications() async {
    setState(() {
      isLoading = true;
    });

    try {
      final notifs = await NotificationService.getNotifications();
      setState(() {
        notifications = notifs;
        isLoading = false;
      });
    } catch (e) {
      _log('Error loading notifications: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _markAsRead(int index) async {
    await NotificationService.markAsRead(index);
    _loadNotifications();
  }

  String _formatTimestamp(int timestamp) {
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter notifications based on selected filter
    List<Map<String, dynamic>> filteredNotifications = notifications
        .where((notif) => filter == 'All' || notif['status'] == filter)
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.pink.shade100,
                      backgroundImage: profileImageUrl.isNotEmpty
                          ? NetworkImage(profileImageUrl)
                          : null, // Display profile image if available
                      child: profileImageUrl.isEmpty
                          ? Icon(Icons.person, color: Colors.grey[600])
                          : null, // Fallback icon if no image available
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back !",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser?.email
                                  ?.split('@')
                                  .first ??
                              "User",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
                // Refresh and Mark All as Read buttons
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isDebugMode ? Icons.bug_report : Icons.refresh,
                        color: isDebugMode ? Colors.orange : Colors.brown[700],
                      ),
                      onPressed: () {
                        if (isDebugMode) {
                          setState(() {
                            isDebugMode = false;
                          });
                        } else {
                          _loadNotifications();
                        }
                      },
                      tooltip: isDebugMode ? 'Exit Debug Mode' : 'Refresh',
                    ),
                    GestureDetector(
                      onLongPress: () {
                        setState(() {
                          isDebugMode = true;
                          _log("Debug mode activated");
                        });
                      },
                      child: IconButton(
                        icon: Icon(Icons.done_all, color: Colors.brown[700]),
                        onPressed: () async {
                          await NotificationService.markAllAsRead();
                          _loadNotifications();
                        },
                        tooltip: 'Mark All as Read',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Debug controls - only show in debug mode
            if (isDebugMode) ...[
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _log(
                          "Current user: ${FirebaseAuth.instance.currentUser?.uid ?? 'Not logged in'}");
                      NotificationService.sendTestNotification();
                      _log("Test notification sent");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 12),
                    ),
                    child: Text('Send Test'),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      _log("Sending direct local notification");

                      // Show a notification directly
                      const AndroidNotificationDetails androidDetails =
                          AndroidNotificationDetails(
                        'counseling_channel',
                        'Counseling Notifications',
                        channelDescription:
                            'Notifications from the counseling system',
                        importance: Importance.high,
                        priority: Priority.high,
                      );

                      const NotificationDetails details = NotificationDetails(
                        android: androidDetails,
                        iOS: DarwinNotificationDetails(),
                      );

                      FlutterLocalNotificationsPlugin()
                          .show(
                        888,
                        'Direct Test',
                        'This is a direct test notification',
                        details,
                      )
                          .then((_) {
                        _log("Direct notification sent successfully");
                      }).catchError((error) {
                        _log("Error sending direct notification: $error");
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 12),
                    ),
                    child: Text('Direct Test'),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      _log("Debugging Firestore connection");
                      NotificationService.debugFirestoreConnection()
                          .then((_) => _log("Debug completed"));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 12),
                    ),
                    child: Text('Debug'),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "User ID: ${FirebaseAuth.instance.currentUser?.uid ?? 'Not logged in'}",
                style: TextStyle(fontSize: 10, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),

              // Debug logs display
              Container(
                height: 60,
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade100,
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _debugLogs,
                    style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
                  ),
                ),
              ),
            ],

            // Notifications Header with Filter Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF660033)),
                ),
                DropdownButton<String>(
                  value: filter,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.brown[700]),
                  style: TextStyle(color: Colors.brown[700]),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      filter = newValue!;
                    });
                  },
                  items: ['All', 'Unread', 'Read']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Notifications List or Empty State
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : filteredNotifications.isEmpty
                      ? _buildEmptyState()
                      : _buildNotificationsList(filteredNotifications),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Notifications is index 1
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
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
            icon: Icon(Icons.add_circle, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              break; // Stay on Notifications screen
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/no_notif.png', height: 250),
          const SizedBox(height: 20),
          const Text(
            "No new notifications",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "There are no new notifications from the guidance council office.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notif = notifications[index];
        final timestamp = notif['timestamp'] ?? 0;
        final timeAgo = _formatTimestamp(timestamp);

        return GestureDetector(
          onTap: () {
            // Mark as read when tapped
            if (notif['status'] == 'Unread') {
              _markAsRead(index);
            }

            // Handle navigation based on notification type
            if (notif['data'] != null) {
              final data = notif['data'];
              if (data['type'] == 'SESSION_UPDATE') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScheduleScreen()),
                );
              }
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: notif['status'] == 'Unread'
                  ? Colors.pink[50]
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.grey[600]),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notif['title'] ?? 'Counseling Office',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[700]),
                          ),
                          Text(
                            timeAgo,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        notif['message'] ?? '',
                        style: TextStyle(color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                notif['status'] == 'Unread'
                    ? CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.notifications,
                          size: 12,
                          color: Colors.white,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
