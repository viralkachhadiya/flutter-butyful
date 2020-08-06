import 'package:Butyful/Utils/color.dart';
import 'package:flutter/material.dart';

class QrBottomShit extends StatelessWidget {
  String newTaskTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200.0,
      child: Text(
        "Invalid Qr Code",
        style: TextStyle(
            fontSize: 20.0, color: primary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
