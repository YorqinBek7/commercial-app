//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:commercial_app/cubits/auth_checker/auth_checker_cubit.dart';
import 'package:commercial_app/cubits/check_connection/check_connection_cubit.dart';
import 'package:commercial_app/cubits/get_all_categories/get_all_categories_cubit.dart';
import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/screens/auth/login_screen.dart';
import 'package:commercial_app/screens/home.dart';
import 'package:commercial_app/screens/splash_screen/splash_screen.dart';

import 'package:commercial_app/utils/notificaton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotification.notification.init();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetAllCategoriesCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCheckerCubit(),
        ),
      ],
      child: BlocProvider(
        create: (context) => CheckConnectionCubit(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        }
        return LoginScreen();
      },
    );
  }
}
