import 'package:flutter/material.dart';

Widget setAppBar({String innerText}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      innerText,
      style: TextStyle(
        color: Colors.black,
        fontSize: 17.0,
      ),
    ),
    // actions: <Widget>[
    //   FlatButton(
    //     child: Text("로그인"),
    //     onPressed: () {},
    //   ),
    // ],
    backgroundColor: Colors.white,
    elevation: 0.0,
  );
}
