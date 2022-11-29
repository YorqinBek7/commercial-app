import 'package:flutter/material.dart';

class ChangerLoginAndRegister extends StatelessWidget {
  final VoidCallback onTap;
  final String txt1;
  final String txt2;
  const ChangerLoginAndRegister({
    Key? key,
    required this.onTap,
    required this.txt1,
    required this.txt2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: txt1,
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: txt2,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
