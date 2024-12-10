import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_rounded_component.dart';
import '../screens/create_consumer_screen.dart';

class LandingPage extends StatelessWidget {
  final String username;

  const LandingPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(username: username),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the Landing Page, $username!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Center(
                child: RoundedButton(
                  label: 'Create Consumer & Rate',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateConsumerPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
