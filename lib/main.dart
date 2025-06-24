import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBqZJK6vfXGEzxk7K987RTu9bxORPQSaUQ",
      appId: "1:206911962785:android:f9bd7f4a5d28da47c83ae0",
      messagingSenderId: "206911962785",
      projectId: "tomato-17886",
    ),
  );
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        // add other routes here if needed
      },
    );
  }
}
