import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginWithButton extends StatelessWidget {
  final String imagePath;
  final String title;

  const LoginWithButton({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
