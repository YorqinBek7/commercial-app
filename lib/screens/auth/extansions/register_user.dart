import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> registerUser(
    {required String email,
    required String password,
    required String name,
    required BuildContext context}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseAuth.instance.currentUser?.updateDisplayName(name);
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message.toString()),
      ),
    );
  }
}
