// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hankkiyo/components/molecules/HAppBar.dart';
import 'package:hankkiyo/components/molecules/HBottomNavigationBar.dart';
import 'package:hankkiyo/components/utils/removeDashes.dart';
// import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

// class LoginData extends InheritedWidget {
//   String phone;
//   String password;

//   LoginData({
//     Key key,
//     @required this.child,
//     @required this.phone,
//     @required this.password,
//   }) : super(key: key, child: child);

//   final Widget child;

//   static LoginData of(BuildContext context) {}

//   @override
//   bool updateShouldNotify(LoginData oldWidget) {
//     return true;
//   }
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HAppBar(title: "로그인"),
      body: Center(
        child: Container(
          width: 335.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              HPhoneInput(),
              SizedBox(
                height: 23.0,
              ),
              HPasswordInput(),
              SizedBox(height: 25, width: double.infinity),
              LoginButton(),
              HRegisterButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HBottomNavigationBar(),
    );
  }
}

class HRegisterButton extends StatelessWidget {
  const HRegisterButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(
            "회원가입",
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () async {
            // Navigator.pushReplacementNamed(context, '/mypage');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            showMyDialog(context, prefs.getString("user_token" ?? ""));
          },
        )
      ],
    );
  }
}

class HPasswordInput extends StatelessWidget {
  const HPasswordInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18.0,
      ),
      maxLength: 100,
      maxLengthEnforced: true,
      cursorColor: Theme.of(context).accentColor,
      obscureText: true,
      decoration: defaultInputDecoration(context, "비밀번호"),
      onChanged: (text) {
        Provider.of<LoginData>(context, listen: false).password = text;
      },
    );
  }
}

class HPhoneInput extends StatelessWidget {
  const HPhoneInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
        _mobileFormatter,
      ],
      maxLength: 13,
      style: TextStyle(
        fontSize: 18.0,
      ),
      cursorColor: Theme.of(context).accentColor,
      keyboardType: TextInputType.phone,
      decoration: defaultInputDecoration(context, "전화번호"),
      onChanged: (String text) {
        String next = removeDashes(text);
        Provider.of<LoginData>(context, listen: false).phone = next;
      },
    );
  }
}

InputDecoration defaultInputDecoration(
    BuildContext context, String placeHolder) {
  return InputDecoration(
    hintText: placeHolder,
    counterText: "",
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).accentColor),
    ),
  );
}

Future<void> showMyDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('로그인 성공'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class NumberTextInputFormatter extends TextInputFormatter {
  String format(String target, int firstDividerIndex, int secondDividerIndex) {
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < target.length; i++) {
      var char = target[i];
      if (i == firstDividerIndex || i == secondDividerIndex) {
        sb.write('-');
      }
      sb.write(char);
    }

    return sb.toString();
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    StringBuffer filteredStringBuilder = new StringBuffer();
    for (int i = 0; i < newValue.text.length; i++) {
      if (newValue.text[i] != '-') {
        filteredStringBuilder.write(newValue.text[i]);
      }
    }

    String filteredString = filteredStringBuilder.toString();

    StringBuffer newText = new StringBuffer();

    if (filteredString.length <= 10) {
      newText.write(format(filteredString, 3, 6));
    } else if (filteredString.length > 10) {
      newText.write(format(filteredString, 3, 7));
    }

    return new TextEditingValue(
      text: newText.toString(),
      selection: TextSelection(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}

final _mobileFormatter = NumberTextInputFormatter();

class LoginButton extends StatefulWidget {
  bool isLoading;

  LoginButton({Key key}) : super(key: key) {
    this.isLoading = false;
  }

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        LoginData state = Provider.of<LoginData>(context, listen: false);
        print("Phone: ${state.phone} Password: ${state.password}");

        String token = await state.login();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_token', token);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.isLoading ? Theme.of(context).accentColor : null,
          border: Border.all(color: Theme.of(context).accentColor),
        ),
        width: 325.0,
        height: 41.0,
        child: Center(
          child: !widget.isLoading
              ? Text(
                  "로그인",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Theme.of(context).accentColor,
                  ),
                )
              : SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
        ),
      ),
    );
  }
}

// class User {
//   final String phone;
//   final String name;

//   User({this.phone, this.name});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       name: json['name']
//     )
//   }
// }
