import 'package:flutter/material.dart';
import 'detection_screen.dart';
import 'dashboard_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          // Top bar with logo and text
          Container(
            width: double.infinity,
            color: Colors.green.shade900,
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.local_florist, color: Colors.white, size: 60),
                SizedBox(height: 10),
                Text(
                  'Tomato Late Blight Detection',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  'Detect and predict late blight in tomatoes\nbased on weather conditions.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Login form section
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    const Text('Log in to your account', style: TextStyle(fontSize: 22)),
                    const SizedBox(height: 30),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DashboardScreen()),
                        );

                        
                      },
                      child: const Text('Log in'),
                    ),
                    const SizedBox(height: 10),
                    TextButton(onPressed: () {}, child: const Text('Forgot password?')),
                    TextButton(onPressed: () {}, child: const Text('Sign up')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
