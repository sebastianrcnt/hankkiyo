import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hankkiyo/components/molecules/HAppBar.dart';
import 'package:hankkiyo/components/molecules/HBottomNavigationBar.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HAppBar(title: "마이페이지"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoTextField(
              placeholder: "SHIT",
            ),
            FlatButton(
              child: Text("나를 누르세요"),
              onPressed: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: HBottomNavigationBar(),
    );
  }
}
