import 'dart:developer';

import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AuthButton(
            onTap: () async {
              Navigator.pop(context);
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn.standard().signOut();
              log(FirebaseAuth.instance.currentUser.toString());
            },
            text: "Log Out",
          )
        ],
      ),
    );
  }
}
