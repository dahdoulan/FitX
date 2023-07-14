import 'package:fitx_flutter_2/Providers/auth.dart';
import 'package:fitx_flutter_2/Providers/user_provider.dart';
import 'package:fitx_flutter_2/constants.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fitx_flutter_2/Widgets/custom_text_field.dart';

import 'package:provider/provider.dart';

class LogIn extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _emailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, UserProvider>(
      builder: (context, auth, user, child) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/images/pexels-murilo-botelho-1865131.JPG'))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            kBlack.withOpacity(0.6),
                            kMoove,
                          ]),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0))),
                  child: Form(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'big_noodle_titling',
                              shadows: [kBoxShadow3]),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          validator: (email) =>
                              email == null || !EmailValidator.validate(email)
                                  ? 'Invalid Email.'
                                  : null,
                          label: 'Email',
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        CustomTextField(
                            validator: (password) => password!.length < 8 ||
                                    password == null
                                ? 'Password should contain 8 characters or more.'
                                : null,
                            label: 'Password',
                            controller: _passwordController),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          height: 50.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                              color: kYellow,
                              boxShadow: [kBoxShadow3],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: TextButton(
                            onPressed: () => auth.logIn(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            ),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                  color: kMoove,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'big_noodle_titling',
                                  shadows: [kBoxShadow2]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
