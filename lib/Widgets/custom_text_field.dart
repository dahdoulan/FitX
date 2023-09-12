import 'package:flutter/material.dart';
import 'package:fitx_flutter_2/constants.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {String? Function(String?)? validator,
      required String label,
      required TextEditingController controller,
      required bool obscureText})
      : _controller = controller,
        _label = label,
        _validator = validator,
        _obsecure = obscureText;

  final TextEditingController _controller;
  final String _label;
  final String? Function(String?)? _validator;
  final bool _obsecure;
  GlobalKey<FormState>? formKey;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    widget.formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Container(
        padding: EdgeInsets.only(right: 5.0, left: 5.0),
        height: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            boxShadow: [
              kBoxShadow3,
            ]),
        child: TextFormField(
          key: widget.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget._validator,
          controller: widget._controller,
          textAlign: TextAlign.center,
          cursorHeight: 25.0,
          cursorColor: kMoove,
          obscureText: widget._obsecure,
          style: TextStyle(
            fontFamily: 'big_noodle_titling',
            color: kMoove,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              label: Text(
                '${widget._label}',
                style: TextStyle(
                  color: kMoove,
                  fontSize: 20.0,
                ),
              )),
        ),
      ),
    );
  }
}
