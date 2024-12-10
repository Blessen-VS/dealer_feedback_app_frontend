import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../components/header_text.dart';
import '../screens/register_screen.dart';
import 'package:sample_app/screens/landing_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 Future<void> _signInWithEmail() async {
  try {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    final user = userCredential.user;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Email Verification"),
          content: Text("A verification email has been sent. Please verify your email to continue."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else if (user != null && user.emailVerified) {
      print("User signed in: ${user.email}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LandingPage(username: user.email ?? 'User'),
        ),
      );
    }
  } catch (e) {
    print("Error: ${e.toString()}");
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Error"),
        content: Text(e.toString()),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeaderText(text: 'Sign In'),
            const SizedBox(height: 40),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _passwordController,
              hintText: 'Password',
              isPassword: true,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Login with Email',
              onPressed: _signInWithEmail,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: const Text(
                'Don\'t have an account? Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
