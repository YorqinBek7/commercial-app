import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetButtons extends StatelessWidget {
  final VoidCallback onTap;
  String text;
  final Color color;
  BottomSheetButtons({
    Key? key,
    required this.onTap,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
