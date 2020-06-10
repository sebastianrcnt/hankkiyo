import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hankkiyo/pages/MyPage.dart';
import 'components/utils/hexToColor.dart';
import 'pages/LoginPage.dart';

final String assetName = 'assets/kakaotalk.svg';
final Widget svgIcon = SvgPicture.asset(assetName,
    color: Colors.red, semanticsLabel: 'A red up arrow');

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: hexToColor("#E0E0E0"),
        accentColor: hexToColor("#EF4B57"),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/mypage': (context) => MyPage(),
      },
    );
  }
}
