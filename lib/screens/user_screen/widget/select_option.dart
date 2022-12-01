import 'package:flutter/material.dart';

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
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        height: 50,
        child: Row(children: [
          Text(text),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(icon))
        ]),
      ),
    );
  }
}
