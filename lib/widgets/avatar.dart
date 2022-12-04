import 'dart:developer';
import 'dart:io';

import 'package:commercial_app/cubits/change_user_info/change_user_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: context.read<ChangeUserInfoCubit>().imageUrl == ""
              ? SizedBox(
                  height: 90,
                  width: 90,
                  child: Image.asset(
                    "assets/images/avatar.png",
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(
                  height: 90,
                  width: 90,
                  child: Image.file(
                    File(context.read<ChangeUserInfoCubit>().imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
// FirebaseAuth.instance.currentUser!.photoURL!