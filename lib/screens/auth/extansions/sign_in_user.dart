import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> signUser(
    {required String email,
    required String password,
    required BuildContext context}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message.toString()),
      ),
    );
    log(e.toString());
  }
}

Future<void> signWithGoogle() async {
  final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? auth = await googleAccount?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: auth?.accessToken,
    idToken: auth?.idToken,
  );
  await FirebaseAuth.instance.signInWithCredential(credential);
  log(FirebaseAuth.instance.currentUser.toString());
}
