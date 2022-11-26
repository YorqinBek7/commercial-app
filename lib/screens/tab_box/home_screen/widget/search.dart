import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  const SearchField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.blueGrey.shade900,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.blueGrey.shade900, fontSize: 14),
        suffixIcon: Icon(
          suffixIcon,
          color: Colors.blueGrey.shade900,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.blueGrey.shade900,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
