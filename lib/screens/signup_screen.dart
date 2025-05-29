import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _autoValidate = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) setState(() => _autoValidate = true);
    });
    _emailFocus.addListener(() {
      if (!_emailFocus.hasFocus) setState(() => _autoValidate = true);
    });
    _passwordFocus.addListener(() {
      if (!_passwordFocus.hasFocus) setState(() => _autoValidate = true);
    });
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name cannot be empty';
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Email cannot be empty';

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Password cannot be empty';
    if (value.length < 4) return 'Password must be at least 4 characters';
    return null;
  }

  Future<void> _signupUser() async {
    setState(() => _autoValidate = true);

    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup Successful!")),
      );

      Navigator.pop(context); // back to login screen
    } on FirebaseAuthException catch (e) {
      String message = "Signup failed.";
      if (e.code == 'email-already-in-use') {
        message = "Email already in use.";
      } else if (e.code == 'weak-password') {
        message = "Password is too weak.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          autovalidateMode:
          _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sign Up', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              TextFormField(
                controller: nameController,
                focusNode: _nameFocus,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: _nameValidator,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                focusNode: _emailFocus,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                focusNode: _passwordFocus,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _passwordValidator,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : _signupUser,
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Create Account'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
