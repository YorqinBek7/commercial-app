import 'dart:async';
import 'dart:developer';

import 'package:commercial_app/screens/auth/login_screen.dart';
import 'package:commercial_app/screens/home.dart';
import 'package:commercial_app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:commercial_app/screens/tab_box/home_screen/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Connectivity connectivity = Connectivity();
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 2));
    connectivity.onConnectivityChanged.listen((event) {
      log("message");
      if (event == ConnectivityResult.none) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoInternetScreen(),
          ),
        );
      } else if (event != ConnectivityResult.none) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeTab(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
