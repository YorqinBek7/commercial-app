// ignore_for_file: use_build_context_synchronously

import 'package:commercial_app/cubits/auth_checker/auth_checker_cubit.dart';
import 'package:commercial_app/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    context.read<AuthCheckerCubit>().userChecker();
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => App(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/app_icon.png"),
      ),
    );
  }
}
