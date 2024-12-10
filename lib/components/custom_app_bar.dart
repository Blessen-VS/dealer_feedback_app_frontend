import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppBarMenu extends StatelessWidget implements PreferredSizeWidget {
  final String username;

  const AppBarMenu({Key? key, required this.username}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Welcome, $username'),
      backgroundColor: Colors.deepPurple,
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'Logout') {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'Logout',
              child: Text('Logout'),
            ),
          ],
        ),
      ],
    );
  }
}
