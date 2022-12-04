import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/user_screen/widget/select_option.dart';
import 'package:commercial_app/screens/user_screen/widget/show_bottom_sheet.dart';
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
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
              onTap: () async {
                await showBottomDialog(
                  context: context,
                  imagePicker: imagePicker,
                  file: file,
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
            TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: "Change user name",
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.done,
                  ),
                  onPressed: () async {
                    focusNode.unfocus();
                    if (textEditingController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter something!"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else {
                      await updateUserName(context);
                      setState(() {});
                    }
                  },
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            AuthButton(
                onTap: () async {
                  focusNode.unfocus();
                  if (textEditingController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter something!"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  } else {
                    await updateUserName(context);
                    setState(() {});
                  }
                },
                text: "Change name"),
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

  Future<void> updateUserName(BuildContext context) async {
    await FirebaseAuth.instance.currentUser!
        .updateDisplayName(textEditingController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("User name successfuly changed"),
      ),
    );
  }
}
