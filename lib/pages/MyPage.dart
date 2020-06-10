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
        child: Text("마이페이지"),
      ),
      bottomNavigationBar: HBottomNavigationBar(),
    );
  }
}
