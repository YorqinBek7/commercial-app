import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 1,
        width: double.infinity,
        color: Colors.grey,
      ),
    );
  }
}
