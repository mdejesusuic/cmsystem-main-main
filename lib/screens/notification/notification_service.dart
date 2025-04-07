// lib/screens/notification/notification_service.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static bool _isInitialized = false;
  static bool _isListening = false;
  static GlobalKey<NavigatorState>? _navigatorKey;

  // In-memory storage for notifications when SharedPreferences fails
  static List<Map<String, dynamic>> _inMemoryNotifications = [];
  static int _unreadCount = 0;

  // Stream controller for notification count
  static final StreamController<int> _notificationCountController =
      StreamController<int>.broadcast();

  // Stream getter for notification count
  static Stream<int> get notificationCountStream =>
      _notificationCountController.stream;

  // Initialize the notification service
  static Future<void> initialize(GlobalKey<NavigatorState> navigatorKey) async {
    if (_isInitialized) return;

    _navigatorKey = navigatorKey;
    print("Initializing notification service");

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        if (response.payload != null) {
          try {
            final data = jsonDecode(response.payload!);
            print("Notification tapped with payload: $data");

            // Handle navigation based on notification type
            if (data['type'] == 'SESSION_UPDATE') {
              navigatorKey.currentState?.pushNamed('/schedule');
            } else if (data['type'] == 'DIRECT_MESSAGE') {
              navigatorKey.currentState?.pushNamed('/notifications');
            }
          } catch (e) {
            print('Error parsing notification payload: $e');
          }
        }
      },
    );

    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'counseling_channel',
      'Counseling Notifications',
      description: 'Notifications from the counseling system',
      importance: Importance.high,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Check notification permissions
    await _checkNotificationPermissions();

    _isInitialized = true;
    print("Notification service initialized");

    // Update notification count initially
    await getUnreadCount();

    // Start listening for auth changes to start/stop the notification listener
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print("User logged in: ${user.uid}");
        startListening();
      } else {
        print("User logged out");
        _isListening = false;
      }
    });
  }

// Check notification permissions
  static Future<void> _checkNotificationPermissions() async {
    try {
      print("Checking notification permissions");

      // For iOS
      if (Platform.isIOS) {
        final settings = await _notificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
        print("iOS notification permission granted: $settings");
      }

      // For Android 13+ (API level 33)
      if (Platform.isAndroid) {
        final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
            _notificationsPlugin.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        if (androidPlugin != null) {
          // Check if notification permission is already granted
          final bool? isPermissionGranted =
              await androidPlugin.areNotificationsEnabled();

          if (!isPermissionGranted!) {
            // Request permission if not already granted
            final bool? granted = await androidPlugin.requestPermission();
            print("Android notification permission granted: $granted");
          } else {
            print("Android notification permission already granted");
          }
        }
      }
    } catch (e) {
      print("Error checking notification permissions: $e");
    }
  }

  // Start listening for notifications
  static Future<void> startListening() async {
    if (!_isInitialized) {
      print("Notification service not initialized");
      if (_navigatorKey != null) {
        await initialize(_navigatorKey!);
      } else {
        print("Cannot initialize: Navigator key is null");
        return;
      }
    }

    if (_isListening) {
      print("Already listening for notifications");
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("Cannot start notification listener: No user logged in");
      return;
    }

    print("Starting notification listener for user: ${user.uid}");
    _isListening = true;

    // Add print statements to debug
    print("Setting up Firestore query for notifications where:");
    print("  - userId == ${user.uid}");
    print("  - sent == false");

    // Listen for new notifications
    FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: user.uid)
        .where('sent', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      print("Notification listener fired. Documents: ${snapshot.docs.length}");

      for (final doc in snapshot.docs) {
        print("Processing notification: ${doc.id}");
        print("Notification data: ${doc.data()}");

        final notification = doc.data();

        // Show the notification
        _showNotification(
          doc.id.hashCode,
          notification['title'] ?? 'New Notification',
          notification['body'] ?? '',
          notification['data'] ?? {},
        );

        // Mark as sent
        FirebaseFirestore.instance
            .collection('notifications')
            .doc(doc.id)
            .update({
          'sent': true,
          'sentAt': FieldValue.serverTimestamp(),
        }).then((_) {
          print("Marked notification ${doc.id} as sent");
        }).catchError((error) {
          print("Error marking notification as sent: $error");
        });
      }
    }, onError: (error) {
      print("Error in notification listener: $error");
      _isListening = false;
    });

    print("Notification listener started");
  }

  // Show a notification
  static Future<void> _showNotification(
    int id,
    String title,
    String body,
    Map<String, dynamic> data,
  ) async {
    print("Showing notification: $title - $body");

    try {
      await _notificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'counseling_channel',
            'Counseling Notifications',
            channelDescription: 'Notifications from the counseling system',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(data),
      );

      print("Notification shown successfully");

      // Save to local storage for notification screen
      await _saveNotificationToLocal(title, body, data);
    } catch (e) {
      print("Error showing notification: $e");
    }
  }

  // Save notification to local storage
  static Future<void> _saveNotificationToLocal(
    String title,
    String body,
    Map<String, dynamic> data,
  ) async {
    try {
      final notification = {
        'title': title,
        'message': body,
        'status': 'Unread',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'data': data,
      };

      try {
        // Try using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        List<String> notifications = prefs.getStringList('notifications') ?? [];
        notifications.add(jsonEncode(notification));
        await prefs.setStringList('notifications', notifications);
        print("Notification saved to SharedPreferences");
      } catch (e) {
        // Fall back to in-memory storage
        print("SharedPreferences failed, using in-memory storage: $e");
        _inMemoryNotifications.add(notification);
        _unreadCount++;
      }

      // Update notification count
      await getUnreadCount();
    } catch (e) {
      print("Error saving notification to local storage: $e");
    }
  }

  // Test method to send a direct local notification
  static Future<void> sendTestNotification() async {
    if (!_isInitialized) {
      print("Cannot send test notification: Service not initialized");
      return;
    }

    await _showNotification(
      999,
      'Test Notification',
      'This is a test notification from the app',
      {'type': 'TEST', 'timestamp': DateTime.now().toString()},
    );
  }

  // Send a direct local notification without using the service
  static Future<void> sendDirectTestNotification() async {
    try {
      print("Sending direct test notification");

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'counseling_channel',
        'Counseling Notifications',
        channelDescription: 'Notifications from the counseling system',
        importance: Importance.high,
        priority: Priority.high,
      );

      const NotificationDetails details = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(),
      );

      await FlutterLocalNotificationsPlugin().show(
        888,
        'Direct Test',
        'This is a direct test notification',
        details,
      );

      print("Direct notification sent successfully");
    } catch (e) {
      print("Error sending direct notification: $e");
    }
  }

  // Get all notifications from local storage
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    try {
      List<Map<String, dynamic>> notifications = [];

      try {
        // Try to get from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        List<String> notificationsJson =
            prefs.getStringList('notifications') ?? [];

        notifications = notificationsJson
            .map((json) => Map<String, dynamic>.from(jsonDecode(json)))
            .toList();
      } catch (e) {
        // Fall back to in-memory storage
        print("SharedPreferences failed, using in-memory storage: $e");
        notifications = List.from(_inMemoryNotifications);
      }

      // Sort by timestamp (newest first)
      notifications.sort(
          (a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int));

      return notifications;
    } catch (e) {
      print("Error getting notifications from local storage: $e");
      return [];
    }
  }

  // Get unread notification count
  static Future<int> getUnreadCount() async {
    try {
      int count = 0;

      try {
        // Try to get from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        List<String> notificationsJson =
            prefs.getStringList('notifications') ?? [];

        for (String json in notificationsJson) {
          Map<String, dynamic> notification = jsonDecode(json);
          if (notification['status'] == 'Unread') {
            count++;
          }
        }
      } catch (e) {
        // Fall back to in-memory count
        print("SharedPreferences failed, using in-memory count: $e");
        count = _unreadCount;
      }

      // Update the stream
      _notificationCountController.add(count);

      return count;
    } catch (e) {
      print("Error getting unread count: $e");
      return 0;
    }
  }

  // Mark notification as read
  static Future<void> markAsRead(int index) async {
    try {
      try {
        // Try using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        List<String> notificationsJson =
            prefs.getStringList('notifications') ?? [];

        if (index < notificationsJson.length) {
          Map<String, dynamic> notification =
              jsonDecode(notificationsJson[index]);
          notification['status'] = 'Read';
          notificationsJson[index] = jsonEncode(notification);

          await prefs.setStringList('notifications', notificationsJson);
        }
      } catch (e) {
        // Fall back to in-memory storage
        print("SharedPreferences failed, using in-memory storage: $e");
        if (index < _inMemoryNotifications.length) {
          if (_inMemoryNotifications[index]['status'] == 'Unread') {
            _inMemoryNotifications[index]['status'] = 'Read';
            _unreadCount = _unreadCount > 0 ? _unreadCount - 1 : 0;
          }
        }
      }

      // Update count
      await getUnreadCount();
    } catch (e) {
      print("Error marking notification as read: $e");
    }
  }

  // Mark all notifications as read
  static Future<void> markAllAsRead() async {
    try {
      try {
        // Try using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        List<String> notificationsJson =
            prefs.getStringList('notifications') ?? [];

        List<String> updatedNotifications = notificationsJson.map((json) {
          Map<String, dynamic> notification = jsonDecode(json);
          notification['status'] = 'Read';
          return jsonEncode(notification);
        }).toList();

        await prefs.setStringList('notifications', updatedNotifications);
      } catch (e) {
        // Fall back to in-memory storage
        print("SharedPreferences failed, using in-memory storage: $e");
        for (var notification in _inMemoryNotifications) {
          notification['status'] = 'Read';
        }
        _unreadCount = 0;
      }

      // Update count
      await getUnreadCount();
    } catch (e) {
      print("Error marking all notifications as read: $e");
    }
  }

  // Debug Firestore connection
  static Future<void> debugFirestoreConnection() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("Cannot debug: No user logged in");
        return;
      }

      print("Debugging Firestore connection for user: ${user.uid}");

      // Try to get notifications collection
      final snapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .limit(5)
          .get();

      print("Successfully connected to Firestore");
      print(
          "Found ${snapshot.docs.length} documents in notifications collection");

      // Try to get user's notifications
      final userSnapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('userId', isEqualTo: user.uid)
          .get();

      print(
          "Found ${userSnapshot.docs.length} notifications for user ${user.uid}");

      for (final doc in userSnapshot.docs) {
        print("Notification: ${doc.id}");
        print("  Data: ${doc.data()}");
      }
    } catch (e) {
      print("Error debugging Firestore connection: $e");
    }
  }

  // Dispose resources
  static void dispose() {
    _notificationCountController.close();
  }
  // In your NotificationService class, add this method:

// Handle notification tap based on type
  static void handleNotificationTap(
      Map<String, dynamic> data, BuildContext context) {
    if (!data.containsKey('type')) return;

    final type = data['type'];

    switch (type) {
      // Session Status Updates
      case 'SESSION_CONFIRMED':
      case 'SESSION_RESCHEDULED':
      case 'SESSION_CANCELLED':
      case 'SESSION_REMINDER_24H':
      case 'SESSION_REMINDER_1H':
      case 'NO_SHOW_FOLLOWUP':
        // Navigate to the schedule screen with the specific session highlighted
        final sessionId = data['sessionId'];
        Navigator.pushNamed(context, '/schedule',
            arguments: {'highlightSessionId': sessionId});
        break;

      // New Submissions (for admin)
      case 'NEW_COUNSELING_REQUEST':
        Navigator.pushNamed(context, '/admin/requests',
            arguments: {'requestId': data['requestId']});
        break;

      // Faculty Referral (for student)
      case 'NEW_FACULTY_REFERRAL':
        Navigator.pushNamed(context, '/notifications');
        // Show a dialog with referral details
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Faculty Referral'),
            content: Text(
                'You have been referred for counseling by ${data['facultyName']}. Reason: ${data['reason']}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/schedule/new');
                },
                child: Text('Schedule Session'),
              ),
            ],
          ),
        );
        break;

      // High Priority Cases
      case 'HIGH_PRIORITY_CASE':
        Navigator.pushNamed(context, '/notifications');
        // Show a dialog with priority information
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Urgent: Counseling Required'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You have been flagged for priority counseling.'),
                SizedBox(height: 8),
                Text('Reason: ${data['reason'] ?? 'Not specified'}'),
                SizedBox(height: 8),
                Text('Contact: ${data['contactPerson'] ?? 'Guidance Office'}'),
                if (data['contactNumber'] != null) ...[
                  SizedBox(height: 4),
                  Text('Phone: ${data['contactNumber']}'),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/schedule/new');
                },
                child: Text('Schedule Session'),
              ),
            ],
          ),
        );
        break;

      // System Notifications
      case 'SYSTEM_UPDATE':
      case 'MAINTENANCE_NOTIFICATION':
        Navigator.pushNamed(context, '/notifications');
        break;

      // Default case - just go to notifications
      default:
        Navigator.pushNamed(context, '/notifications');
        break;
    }
  }
}

extension on AndroidFlutterLocalNotificationsPlugin {
  requestPermission() {}
}
