import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        height: 1.h,
        width: double.infinity,
        color: Colors.grey,
      ),
    );
  }
}
