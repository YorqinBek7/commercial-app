import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class WhenNoElement extends StatelessWidget {
  const WhenNoElement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/lotties/no_data.json",
            width: 350.w,
            height: 350.h,
          ),
        ],
      ),
    );
  }
}
