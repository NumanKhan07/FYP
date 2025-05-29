import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;

  const AppDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(name: userName, email: userEmail),
                ),
              );
            },
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
              accountName: Text(userName),
              accountEmail: Text(userEmail),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile Info'),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Reports'),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Change Location'),
            onTap: () {},
          ),

          const Spacer(),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                try {
                  await FirebaseAuth.instance.signOut();
                  print("User signed out successfully.");
                } catch (e) {
                  print("Error signing out: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Logout failed: $e")),
                  );
                  return;
                }

                Navigator.pop(context); // Close drawer before navigation
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
