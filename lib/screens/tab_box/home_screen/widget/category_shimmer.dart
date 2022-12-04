import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            width: 70.w,
            height: 70.h,
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.w),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 5,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
