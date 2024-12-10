import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './screens/sign_in_screen.dart';
import './screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAwbXSR-jrlmFBDjLwnWP3H5eopaBX0c3Q",
      authDomain: "feedback-app-20e57.firebaseapp.com",
      projectId: "feedback-app-20e57",
      storageBucket: "feedback-app-20e57.firebasestorage.app",
      messagingSenderId: "569282227048",
      appId: "1:569282227048:web:574a8eb05cbd29b9ee84dd",
      measurementId: "G-5JK86F4DY5",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If the user is logged in and their email is verified
        if (snapshot.hasData && snapshot.data!.emailVerified) {
          final User user = snapshot.data!;
          return LandingPage(username: user.email ?? 'User');
        }

        // Otherwise, show the sign-in screen
        return SignInScreen();
      },
    );
  }
}
