import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/auth/widgets/field_for_text.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "📨",
                style: TextStyle(fontSize: 60),
              ),
              SizedBox(
                height: 42,
              ),
              Text(
                "Forget Password",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 24,
              ),
              FieldForText(hintText: "Enter your email"),
              SizedBox(
                height: 32,
              ),
              AuthButton(onTap: () {}, text: "Continue")
            ],
          ),
        ),
      ),
    );
  }
}
