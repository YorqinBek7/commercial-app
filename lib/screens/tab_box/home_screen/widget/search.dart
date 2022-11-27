import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final ValueChanged onChanged;
  const SearchField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.blueGrey.shade900,
        ),
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.blueGrey.shade900, fontSize: 14),
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
