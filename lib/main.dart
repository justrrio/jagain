import 'package:flutter/material.dart';
import 'package:jagain/pages/home.dart'; // Widget Library

void main() {
  // App entry point
  runApp(
      // Take the scene into runApp function by passing a widget as a parameter
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
