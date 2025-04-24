import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const TomatoBlightApp());
}

class TomatoBlightApp extends StatelessWidget {
  const TomatoBlightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomato Late Blight Detection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginScreen(),
    );
  }
}
