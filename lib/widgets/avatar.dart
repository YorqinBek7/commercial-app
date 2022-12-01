import 'dart:io';

import 'package:commercial_app/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatelessWidget {
  final XFile? image;
  final VoidCallback onTap;

  const Avatar({
    Key? key,
    this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: sharedPreferences!.getString("image") == null
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
                    File(sharedPreferences!.getString("image")!),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
