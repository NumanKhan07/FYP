import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;

  const ProfileScreen({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Info"), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.account_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            Text("Name: $name", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Email: $email", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            const Text("This is your registered profile information.",
                style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
