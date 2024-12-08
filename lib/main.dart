import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase library
import 'package:jagain/pages/home.dart'; // Widget Library

void main() async {
  // App entry point

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
      // Take the scene into runApp function by passing a widget as a parameter
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jagain Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(color: const Color(0xffD9FFEE)),
      ),
      home: const HomePage(),
    );
  }
}
