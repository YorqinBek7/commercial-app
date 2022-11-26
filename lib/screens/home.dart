// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:commercial_app/screens/tab_box/cart_screen/cart_screen.dart';
import 'package:commercial_app/screens/tab_box/home_screen/home_screen.dart';
import 'package:commercial_app/screens/tab_box/user_screen/user_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [HomeTab(), CartPage(), UserPage()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_outlined),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: "Users",
            ),
          ]),
    );
  }
}
