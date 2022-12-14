import 'package:commercial_app/screens/notification_screen/notification_screen.dart';
import 'package:commercial_app/widgets/avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final VoidCallback onTap;

  const CustomAppBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.grey.shade100,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0,
      backgroundColor: Colors.grey.shade100,
      leading: Avatar(
        onTap: onTap,
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          getTime(),
          style: TextStyle(color: Colors.blueGrey.shade900, fontSize: 14.sp),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          FirebaseAuth.instance.currentUser!.displayName ?? "",
          style: TextStyle(color: Colors.blueGrey.shade900, fontSize: 17.sp),
        ),
      ]),
      actions: [
        InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationScreen(),
              ),
            )
          },
          child: const Icon(
            Icons.notifications,
            size: 30,
            color: Colors.yellow,
            shadows: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 5.w,
        )
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size(double.infinity, 70);
}

String getTime() {
  if (DateTime.now().hour >= 4 && DateTime.now().hour < 12) {
    return tr("good_morning");
  } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
    return tr("good_afternoon");
  } else {
    return tr("good_night");
  }
}
