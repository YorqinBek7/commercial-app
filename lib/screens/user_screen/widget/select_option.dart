import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectOptionsWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  const SelectOptionsWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        height: 50.h,
        child: Row(children: [
          Text(text),
          const Spacer(),
          IconButton(onPressed: () {}, icon: Icon(icon))
        ]),
      ),
    );
  }
}
