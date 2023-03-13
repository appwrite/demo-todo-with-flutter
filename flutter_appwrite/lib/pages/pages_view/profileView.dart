import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  models.Account user;
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
