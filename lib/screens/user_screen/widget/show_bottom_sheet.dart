import 'package:commercial_app/cubits/change_user_info/change_user_info_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

showBottomDialog({
  required BuildContext context,
  XFile? file,
  required ImagePicker imagePicker,
}) async {
  showModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: 200,
      child: Column(
        children: [
          SizedBox(height: 15.h),
          Text(
            tr("pick_profile_photo"),
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          ListTile(
            title: Text(
              tr("from_camera"),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.camera_alt_outlined),
            onTap: () async {
              file = await imagePicker.pickImage(
                source: ImageSource.camera,
              );
              await FirebaseAuth.instance.currentUser!
                  .updatePhotoURL(file!.path);
              context.read<ChangeUserInfoCubit>().changeUserInfo(
                  image: FirebaseAuth.instance.currentUser!.photoURL!,
                  name: FirebaseAuth.instance.currentUser!.displayName!);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              tr("from_gallery"),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.image),
            onTap: () async {
              file = await imagePicker.pickImage(source: ImageSource.gallery);
              await FirebaseAuth.instance.currentUser!
                  .updatePhotoURL(file!.path);
              context.read<ChangeUserInfoCubit>().changeUserInfo(
                  image: FirebaseAuth.instance.currentUser!.photoURL!,
                  name: FirebaseAuth.instance.currentUser!.displayName!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
