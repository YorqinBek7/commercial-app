import 'dart:io';
import 'package:commercial_app/cubits/change_user_info/change_user_info_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Avatar extends StatelessWidget {
  final VoidCallback onTap;

  const Avatar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 7.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: BlocBuilder<ChangeUserInfoCubit, ChangeUserInfoState>(
            builder: (context, state) {
              if (state is UserChanged) {
                return const CircularProgressIndicator();
              } else if (state is UserChangingState) {
                return FirebaseAuth.instance.currentUser?.photoURL == null
                    ? SizedBox(
                        height: 90.h,
                        width: 90.w,
                        child: Image.asset(
                          "assets/images/avatar.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(
                        height: 90.h,
                        width: 90.w,
                        child: Image.file(
                          File(FirebaseAuth.instance.currentUser!.photoURL!),
                          fit: BoxFit.cover,
                        ),
                      );
              }
              return SizedBox(
                height: 90.h,
                width: 90.w,
                child: Image.asset(
                  "assets/images/avatar.png",
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
