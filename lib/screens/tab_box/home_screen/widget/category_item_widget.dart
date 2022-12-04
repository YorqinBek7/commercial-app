import 'package:commercial_app/repository/myrepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    Key? key,
    required this.selected,
    required this.myRepository,
    required this.data,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final int selected;
  final MyRepository myRepository;
  final List<String> data;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected == index ? Colors.black : Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(1, 1), blurRadius: 5, color: Colors.grey)
                  ]),
              child: Image.asset(
                myRepository.images[index],
                width: 30.w,
                height: 30.h,
                color: selected != index ? Colors.black : Colors.white,
              ),
            ),
            Expanded(
              child: Text(
                data[index],
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
