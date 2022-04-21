import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  User user;
  ProfileView({
    this.user,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            if (user != null) ...[
              Text(user.email),
              Text(user.name),
              if (user.prefs.data['photo'] != null) ...[],
            ],
          ],
        ),
      ),
    );
  }
}
