import 'package:commercial_app/cubits/select_language/select_language_cubit.dart';
import 'package:commercial_app/screens/auth/widgets/auth_button.dart';
import 'package:commercial_app/screens/user_screen/widget/select_option.dart';
import 'package:commercial_app/screens/user_screen/widget/show_bottom_sheet.dart';
import 'package:commercial_app/widgets/avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  int selectLanguage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.r),
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
            SizedBox(height: 20.h),
            Text(
              FirebaseAuth.instance.currentUser!.displayName!,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: tr("change_name"),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.done,
                  ),
                  onPressed: () async {
                    focusNode.unfocus();
                    if (textEditingController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(tr("please_enter_something")),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else {
                      await updateUserName(context);
                      setState(() {});
                    }
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.h),
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
                text: tr("change_name")),
            SizedBox(height: 10.h),
            SelectOptionsWidget(
              icon: Icons.language_outlined,
              text: tr('language'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Builder(builder: (context) {
                            return ListTile(
                              title: const Text("Uzbek"),
                              trailing: const Text("🇺🇿"),
                              selected: selectLanguage == 0,
                              selectedTileColor: Colors.blue.withOpacity(0.1),
                              selectedColor: Colors.green,
                              onTap: () {
                                setState(
                                  () {
                                    selectLanguage = 0;
                                    context
                                        .read<SelectLanguageCubit>()
                                        .selectUzbekLanguage();
                                    context.setLocale(const Locale('uz', 'UZ'));
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          }),
                          ListTile(
                            title: const Text("English"),
                            trailing: const Text("🏴󠁧󠁢󠁥󠁮󠁧󠁿"),
                            selected: selectLanguage == 1,
                            selectedTileColor: Colors.blue.withOpacity(0.1),
                            selectedColor: Colors.green,
                            onTap: () {
                              setState(
                                () {
                                  selectLanguage = 1;
                                  context
                                      .read<SelectLanguageCubit>()
                                      .selectEnglandLanguage();
                                  context.setLocale(const Locale('en', 'EN'));
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
            SelectOptionsWidget(
              icon: Icons.privacy_tip_outlined,
              text: tr('privacy_police'),
              onTap: () {},
            ),
            SelectOptionsWidget(
              icon: Icons.people_alt,
              text: tr('about'),
              onTap: () {},
            ),
            Spacer(),
            AuthButton(
              onTap: () async {
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn.standard().signOut();
              },
              text: tr("log_out"),
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
        content: Text(tr("snackbar_success_change_name")),
      ),
    );
  }
}
