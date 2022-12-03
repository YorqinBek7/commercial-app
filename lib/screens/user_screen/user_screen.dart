import 'dart:developer';
import 'dart:io';

import 'package:commercial_app/main.dart';
import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/user_screen/widget/select_option.dart';
import 'package:commercial_app/widgets/avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  XFile? file;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Avatar(
              image: file,
              onTap: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          "Pick profile photo",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        ListTile(
                          title: Text(
                            "Select from Camera",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(Icons.camera_alt_outlined),
                          onTap: () async {
                            Navigator.pop(context);
                            file = await imagePicker.pickImage(
                              source: ImageSource.camera,
                            );
                            await sharedPreferences!
                                .setString("image", file!.path);
                          },
                        ),
                        ListTile(
                          title: Text(
                            "Select from Gallery",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(Icons.image),
                          onTap: () async {
                            Navigator.pop(context);
                            file = await imagePicker.pickImage(
                              source: ImageSource.gallery,
                            );
                            await sharedPreferences!
                                .setString("image", file!.path);

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              FirebaseAuth.instance.currentUser!.displayName!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            SelectOptionsWidget(
              icon: Icons.language_outlined,
              text: 'Language',
              onTap: () {},
            ),
            SelectOptionsWidget(
              icon: Icons.privacy_tip_outlined,
              text: 'Privacy Police',
              onTap: () {},
            ),
            SelectOptionsWidget(
              icon: Icons.people_alt,
              text: 'About',
              onTap: () {},
            ),
            Spacer(),
            AuthButton(
              onTap: () async {
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn.standard().signOut();
              },
              text: "Log Out",
            )
          ],
        ),
      ),
    );
  }
}
