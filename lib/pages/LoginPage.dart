import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hankkiyo/components/molecules/HAppBar.dart';
import 'package:hankkiyo/components/molecules/HBottomNavigationBar.dart';
import 'package:hankkiyo/components/molecules/LoginButton.dart';

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
              TextFormField(
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
                decoration: InputDecoration(
                  hintText: "전화번호",
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
              SizedBox(
                height: 23.0,
              ),
              TextField(
                style: TextStyle(
                  fontSize: 18.0,
                ),
                cursorColor: Theme.of(context).accentColor,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "비밀번호",
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor))),
              ),
              SizedBox(height: 25, width: double.infinity),
              LoginButton(innerText: "로그인"),
              Row(
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
                    onPressed: () {
                      // Navigator.pushReplacementNamed(context, '/mypage');
                      showMyDialog(context);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HBottomNavigationBar(),
    );
  }
}

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('로그인 실패'),
        content: Text('아이디 혹은 비밀번호를 확인해주세요.'),
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
