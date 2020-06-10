import 'package:flutter/material.dart';

class HAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        this.title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
    );
  }

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
