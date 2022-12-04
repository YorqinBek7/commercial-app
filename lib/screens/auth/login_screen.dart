import 'package:commercial_app/screens/auth/forgot_pass_screen.dart';
import 'package:commercial_app/screens/auth/register.dart';
import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/auth/widgets/changer_login_and_register.dart';
import 'package:commercial_app/screens/auth/widgets/field_for_text.dart';
import 'package:commercial_app/screens/auth/widgets/line_widget.dart';
import 'package:commercial_app/screens/auth/widgets/login_with_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.all(8.0.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Text(
                  "👋",
                  style: TextStyle(fontSize: 60.sp),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                tr("sign_in"),
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 34.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              LoginWithButton(
                imagePath: "assets/svg/google.svg",
                title: 'Google',
                onTap: () async {
                  try {
                    await signWithGoogle();
                  } catch (e) {}
                },
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  const LineWidget(),
                  Text(tr("or")),
                  const LineWidget(),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              FieldForText(
                hintText: "Email",
                controller: emailController,
              ),
              SizedBox(
                height: 16.h,
              ),
              FieldForText(
                hintText: tr("password"),
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
                height: 8.h,
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
                      tr("forgot_password"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              AuthButton(
                onTap: () async {
                  await signUser(
                    email: emailController.text,
                    password: passwordController.text,
                    context: context,
                  );
                },
                text: tr("log_in"),
              ),
              SizedBox(
                height: 16.h,
              ),
              ChangerLoginAndRegister(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                txt1: tr("dont_have_an_account"),
                txt2: " ${tr("sign_up")}",
              )
            ],
          ),
        ),
      ),
    );
  }
}
