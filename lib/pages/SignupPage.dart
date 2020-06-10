
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hankkiyo/components/molecules/HAppBar.dart';

import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HAppBar(title: "회원가입"),
      body: Center(
        child: Container(
          width: 335.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HPhoneInput(),
              SizedBox(height: 23.0),
            ],
          ),
        ),
      ),
    );
  }
}
