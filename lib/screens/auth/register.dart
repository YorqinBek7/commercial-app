import 'package:commercial_app/screens/auth/extansions/sign_in_user.dart';
import 'package:commercial_app/screens/auth/login_screen.dart';
import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/auth/widgets/changer_login_and_register.dart';
import 'package:commercial_app/screens/auth/widgets/field_for_text.dart';
import 'package:commercial_app/screens/auth/widgets/line_widget.dart';
import 'package:commercial_app/screens/auth/widgets/login_with_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  "👏",
                  style: TextStyle(fontSize: 60.sp),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                tr("sign_up"),
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 34.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              LoginWithButton(
                imagePath: "assets/svg/google.svg",
                title: 'Google',
                onTap: () async {
                  await signWithGoogle();
                },
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  const LineWidget(),
                  Text(tr("or")),
                  const LineWidget(),
                ],
              ),
              SizedBox(height: 30.h),
              FieldForText(
                hintText: tr("name"),
                controller: nameController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return tr("please_enter_something");
                  } else if (value.length < 3) {
                    return tr("name_length");
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              FieldForText(
                hintText: "Email/Phone Number",
                controller: emailController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return tr("please_enter_something");
                  } else if (!EmailValidator.validate(value)) {
                    return tr("please_enter_correct_email");
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              FieldForText(
                hintText: tr("password"),
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
                    return tr("please_enter_something");
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              AuthButton(
                onTap: () async {
                  await registerUser(
                    email: emailController.text,
                    name: nameController.text,
                    password: passwordController.text,
                    context: context,
                  );
                },
                text: tr("create_account"),
              ),
              SizedBox(height: 16.h),
              ChangerLoginAndRegister(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                txt1: tr("do_you_have_an_account"),
                txt2: ' ${tr('sign_in')}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
