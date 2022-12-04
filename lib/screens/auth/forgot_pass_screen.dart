import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/auth/widgets/field_for_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "📨",
                style: TextStyle(fontSize: 60.sp),
              ),
              SizedBox(
                height: 42.h,
              ),
              Text(
                tr("restore_password"),
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "message_about_forgot_password",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.pink,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              FieldForText(
                hintText: tr("enter_your_email"),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr("please_enter_somthing");
                  } else if (!EmailValidator.validate(value)) {
                    return tr("please_enter_correct_email");
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 32.h,
              ),
              AuthButton(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text.trim());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(tr("reset_password_sent")),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.message.toString()),
                      ),
                    );
                  }
                },
                text: tr("continue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
