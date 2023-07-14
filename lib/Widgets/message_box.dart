import 'package:flutter/material.dart';

import '../constants.dart';

class MessageBox extends StatelessWidget {
  MessageBox(String text) {
    this.text = text;
  }

  String text = 'No message found.';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kYellow,
      title: Text(
        text,
        style: kMessageBoxTextStyle,
      ),
    );
  }
}
