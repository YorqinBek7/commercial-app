import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginWithButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const LoginWithButton({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(.1),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath),
            SizedBox(
              width: 5.w,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
