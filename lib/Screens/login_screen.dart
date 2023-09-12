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

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, UserProvider>(
      builder: (context, auth, user, child) {
        return Scaffold(
          backgroundColor: kMoove,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Image.asset(
                          './assets/images/undraw.png',
                          width: 300.0,
                        ),
                      ),
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
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      CustomTextField(
                        validator: (password) => password!.length < 8
                            ? 'Password should contain 8 characters or more.'
                            : null,
                        label: 'Password',
                        controller: _passwordController,
                        obscureText: true,
                      ),
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
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => Center(
                                child: CircularProgressIndicator(
                                  color: kYellow,
                                ),
                              ),
                            );
                            await auth.logIn(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                            Navigator.pop(context);
                          },
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
              ],
            ),
          ),
        );
      },
    );
  }
}
