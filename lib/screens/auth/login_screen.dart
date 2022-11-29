// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:commercial_app/screens/auth/forgot_pass_screen.dart';
import 'package:commercial_app/screens/auth/register.dart';
import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/auth/widgets/changer_login_and_register.dart';
import 'package:commercial_app/screens/auth/widgets/field_for_text.dart';
import 'package:commercial_app/screens/auth/widgets/line_widget.dart';
import 'package:commercial_app/screens/auth/widgets/login_with_button.dart';
import 'package:flutter/material.dart';

import 'extansions/sign_in_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidePassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  "👋",
                  style: TextStyle(fontSize: 60),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              LoginWithButton(
                imagePath: "assets/svg/google.svg",
                title: 'Google',
                onTap: () async {
                  try {
                    await signWithGoogle();
                  } catch (e) {
                    log(e.toString());
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  LineWidget(),
                  Text("Or"),
                  LineWidget(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              FieldForText(
                hintText: "Email",
                controller: emailController,
              ),
              SizedBox(
                height: 16,
              ),
              FieldForText(
                hintText: "Password",
                isObscure: isHidePassword,
                onTap: () {
                  setState(() => {
                        isHidePassword = !isHidePassword,
                      });
                },
                icon: isHidePassword ? Icons.visibility : Icons.visibility_off,
                controller: passwordController,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 32,
              ),
              AuthButton(
                onTap: () async {
                  await signUser(
                    email: emailController.text,
                    password: passwordController.text,
                    context: context,
                  );
                },
                text: 'Log in',
              ),
              SizedBox(
                height: 16,
              ),
              ChangerLoginAndRegister(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                txt1: "Don't have account?",
                txt2: " Sign Up",
              )
            ],
          ),
        ),
      ),
    );
  }
}
