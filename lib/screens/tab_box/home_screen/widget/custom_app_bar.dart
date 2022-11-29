import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: onTap, child: Image.asset("assets/images/avatar.png")),
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Good Morning",
          style: TextStyle(color: Colors.blueGrey.shade900, fontSize: 14),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "YorqinBek Yuldashev",
          style: TextStyle(color: Colors.blueGrey.shade900, fontSize: 17),
        ),
      ]),
      actions: [
        InkWell(
          onTap: () => {},
          child: Icon(
            Icons.notifications,
            size: 30,
            color: Colors.yellow,
            shadows: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 5,
        )
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size(double.infinity, 70);
}
