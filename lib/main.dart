//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:commercial_app/cubits/get_all_categories/get_all_categories_cubit.dart';
import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
