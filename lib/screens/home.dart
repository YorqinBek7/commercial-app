// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:commercial_app/cubits/check_connection/check_connection_cubit.dart';
import 'package:commercial_app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:commercial_app/screens/tab_box/cart_screen/cart_screen.dart';
import 'package:commercial_app/screens/tab_box/home_screen/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [HomeTab(), CartPage()];
  int currentIndex = 0;
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckConnectionCubit, CheckConnectionState>(
      listener: (context, state) {
        if (state is CheckConnectionNone) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoInternetScreen(voidCallback: _init),
            ),
          );
        }
      },
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => {
            setState(
              () => {
                currentIndex = value,
              },
            )
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: tr("home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_outlined),
              label: tr("cart"),
            ),
          ],
        ),
      ),
    );
  }
}
