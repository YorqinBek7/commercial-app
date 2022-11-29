import 'package:flutter/material.dart';

class FieldForText extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final VoidCallback? onTap;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final bool? isObscure;
  const FieldForText({
    Key? key,
    required this.hintText,
    this.icon,
    this.onTap,
    required this.controller,
    this.validator,
    this.isObscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey<FormState>(),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        obscureText: isObscure ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          fillColor: Colors.blue.withOpacity(.1),
          filled: true,
          suffixIcon: icon == null
              ? null
              : IconButton(
                  onPressed: onTap,
                  icon: Icon(icon),
                ),
        ),
      ),
    );
  }
}
