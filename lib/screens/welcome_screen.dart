// File: lib/screens/welcome_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotationAnimation;
  late AnimationController _textController;
  late Animation<double> _fadeTextAnimation;

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Shorter duration
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _iconController, curve: Curves.easeOut));

    _rotationAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _iconController, curve: Curves.easeInOut));

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeTextAnimation =
        Tween<double>(begin: 0, end: 1).animate(_textController);

    _iconController.forward().then((_) => _textController.forward());

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: RotationTransition(
                turns: _rotationAnimation,
                child:
                const Icon(Icons.local_florist, color: Colors.white, size: 80),
              ),
            ),
            const SizedBox(height: 30),
            FadeTransition(
              opacity: _fadeTextAnimation,
              child: const Text(
                'Welcome to Tomato Blight App',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
