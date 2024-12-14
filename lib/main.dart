import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jagain/pages/home.dart';
import 'package:jagain/pages/camera.dart'; // Import your camera page
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Awesome Notifications with on tap functionality
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "jagain",
          channelName: "Jagain Notifications",
          channelDescription: 'Terdeteksi suara keras!',
        ),
      ],
      debug: true);
  // Set up listener for when a notification is tapped
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: handleNotificationTap,
  );

  await Firebase.initializeApp();
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

// This method will be called when a notification is tapped
@pragma("vm:entry-point")
Future<void> handleNotificationTap(ReceivedAction receivedAction) async {
  // Assuming you're using a navigation key or context from the app
  // This is a global key that you'll set up in your MyApp widget
  navigateToCamera();
}

// Global function to navigate to camera page
void navigateToCamera() {
  // Use a global key or implement your navigation logic
  // For example:
  navigatorKey.currentState
      ?.push(MaterialPageRoute(builder: (context) => CameraPage()));
}

// Create a global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseDatabase.instance.ref().child('esp32camdata');

    dbRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map?;

      if (data is Map && (data['soundDetected'] == true)) {
        triggerNotification();
      }
    });

    return MaterialApp(
      navigatorKey: navigatorKey, // Add this line
      debugShowCheckedModeBanner: false,
      title: 'Jagain Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(color: const Color(0xffD9FFEE)),
      ),
      home: const HomePage(),
    );
  }

  triggerNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'jagain',
          title: 'Warning',
          body: 'Terdengar suara keras!',
          // Add this line to enable tap action
          notificationLayout: NotificationLayout.Default,
          wakeUpScreen: true,
        ),
        // Add actionButtons if you want more interaction
        actionButtons: [
          NotificationActionButton(
            key: 'go_to_live_camera',
            label: 'Go to Live Camera',
            // This will trigger the handleNotificationTap method
          )
        ]);
  }
}
