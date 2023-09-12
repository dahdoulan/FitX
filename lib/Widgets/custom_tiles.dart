import 'package:flutter/material.dart';

import '../constants.dart';

class CustomListTiles extends StatelessWidget {
  String? _leading = '';
  var _trailing;
  CustomListTiles({required leading, required trailing, fav})
      : _leading = leading,
        _trailing = trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            kBoxShadow,
          ],
          color: kYellow,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: ListTile(
          leading: Text(_leading!, style: TextStyle(color: kMoove)),
          trailing: _trailing!,
        ),
      ),
    );
  }
}
