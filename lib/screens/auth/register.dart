// ignore_for_file: prefer_const_constructors

import 'package:commercial_app/screens/auth/login_screen.dart';
import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/auth/widgets/field_for_text.dart';
import 'package:commercial_app/screens/auth/widgets/line_widget.dart';
import 'package:commercial_app/screens/auth/widgets/login_with_button.dart';
import 'package:commercial_app/screens/home.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isHidePassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "👏",
                  style: TextStyle(fontSize: 60),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 34,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: LoginWithButton(
                      imagePath: "assets/svg/facebook.svg",
                      title: 'Facebook',
                    ),
                  ),
                  Expanded(
                    child: LoginWithButton(
                      imagePath: "assets/svg/google.svg",
                      title: 'Google',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: const [
                  LineWidget(),
                  Text("Or"),
                  LineWidget(),
                ],
              ),
              SizedBox(height: 30),
              FieldForText(
                hintText: "Name",
              ),
              SizedBox(height: 16),
              FieldForText(
                hintText: "Email/Phone Number",
              ),
              SizedBox(height: 16),
              FieldForText(
                hintText: "Password",
                onTap: () {
                  setState(
                    () => {
                      isHidePassword = !isHidePassword,
                    },
                  );
                },
                icon: isHidePassword ? Icons.visibility : Icons.visibility_off,
              ),
              SizedBox(height: 16),
              AuthButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                text: "Create Account",
              ),
              SizedBox(height: 16),
              TextButton(
                child: RichText(
                  text: TextSpan(
                    children: const [
                      TextSpan(
                        text: "Do you have account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: " Sign In",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
