import 'package:flutter/material.dart';

class HBottomNavigationBar extends StatefulWidget {
  @override
  _HBottomNavigationBarState createState() => _HBottomNavigationBarState();
}

class _HBottomNavigationBarState extends State<HBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).accentColor,
      currentIndex: 1,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/login');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/mypage');
            break;
          default:
            break;
        }
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("홈"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text("마이페이지"),
        ),
      ],
    );
  }
}
