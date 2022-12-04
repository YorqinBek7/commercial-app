// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:commercial_app/screens/auth/extansions/sign_in_user.dart';
import 'package:commercial_app/screens/auth/login_screen.dart';
import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/auth/widgets/changer_login_and_register.dart';
import 'package:commercial_app/screens/auth/widgets/field_for_text.dart';
import 'package:commercial_app/screens/auth/widgets/line_widget.dart';
import 'package:commercial_app/screens/auth/widgets/login_with_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'extansions/register_user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isHidePassword = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
              LoginWithButton(
                imagePath: "assets/svg/google.svg",
                title: 'Google',
                onTap: () async {
                  await signWithGoogle();
                },
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
                controller: nameController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter something!";
                  } else if (value.length < 3) {
                    return "Name length should be longer than 3";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              FieldForText(
                hintText: "Email/Phone Number",
                controller: emailController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter something!";
                  } else if (!EmailValidator.validate(value)) {
                    return "Please enter correct email!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              FieldForText(
                hintText: "Password",
                isObscure: isHidePassword,
                onTap: () {
                  setState(
                    () => {
                      isHidePassword = !isHidePassword,
                    },
                  );
                },
                icon: isHidePassword ? Icons.visibility : Icons.visibility_off,
                controller: passwordController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter something!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              AuthButton(
                onTap: () async {
                  await registerUser(
                    email: emailController.text,
                    name: nameController.text,
                    password: passwordController.text,
                    context: context,
                  );
                },
                text: "Create Account",
              ),
              SizedBox(height: 16),
              ChangerLoginAndRegister(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                txt1: 'Do you have account?',
                txt2: ' Sign in',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
