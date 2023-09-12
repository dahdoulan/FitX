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
      actions: [
        TextButton(
            onPressed: () => Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                ),
            child: Text(
              'Ok',
              style: kMessageBoxTextStyle,
            )),
      ],
      backgroundColor: kYellow,
      title: Text(
        text,
        style: kMessageBoxTextStyle,
      ),
    );
  }
}
