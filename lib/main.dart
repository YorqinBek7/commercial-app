//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:commercial_app/cubits/auth_checker/auth_checker_cubit.dart';
import 'package:commercial_app/cubits/change_user_info/change_user_info_cubit.dart';
import 'package:commercial_app/cubits/check_connection/check_connection_cubit.dart';
import 'package:commercial_app/cubits/get_all_categories/get_all_categories_cubit.dart';
import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/screens/splash_screen/splash_screen.dart';

import 'package:commercial_app/utils/notificaton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotification.notification.init();

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
        BlocProvider(
          create: (context) => ChangeUserInfoCubit(),
        ),
        BlocProvider(
          create: (context) => CheckConnectionCubit(),
        )
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
