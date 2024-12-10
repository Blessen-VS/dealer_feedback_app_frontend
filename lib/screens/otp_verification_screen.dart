import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../components/header_text.dart';
import '../screens/register_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmail() async {
    try {
      // Sign in with email and password
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = userCredential.user;
      if (user != null && !user.emailVerified) {
        // User is not verified; show dialog and resend verification email
        await user.sendEmailVerification();
        print("Verification email resent. Please verify to continue.");
        
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Email Verification"),
            content: Text(
              "Your email is not verified. A new verification email has been sent.",
            ),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      } else if (user != null && user.emailVerified) {
        print("User signed in and verified: ${user.email}");
        // Proceed to main screen or home screen
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      // Display error message if needed
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
