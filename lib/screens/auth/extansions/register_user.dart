import 'package:commercial_app/cubits/change_user_info/change_user_info_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> registerUser({
  required String email,
  required String password,
  required String name,
  required BuildContext context,
}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseAuth.instance.currentUser?.updateDisplayName(name);

    context.read<ChangeUserInfoCubit>().changeUserInfo(
        name: FirebaseAuth.instance.currentUser!.displayName!, image: null);
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message.toString()),
      ),
    );
  }
}
