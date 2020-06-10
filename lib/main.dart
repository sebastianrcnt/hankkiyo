import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hankkiyo/pages/MyPage.dart';
import 'package:hankkiyo/pages/SignupPage.dart';
import 'package:provider/provider.dart';
import 'components/utils/hexToColor.dart';
import 'pages/LoginPage.dart';

final String assetName = 'assets/kakaotalk.svg';
final Widget svgIcon = SvgPicture.asset(assetName,
    color: Colors.red, semanticsLabel: 'A red up arrow');

void main() {
  runApp(MyApp());
}

class LoginData extends ChangeNotifier {
  String phone;
  String password;

  LoginData({this.phone, this.password});

  Future<String> login() async {
    Dio dio = new Dio();
    Response response = await dio.post(
      Uri.encodeFull("http://localhost:3000/login"),
      data: {
        'phone': this.phone,
        'password': this.password,
      }
    );

    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['token'];
      } else {
        throw Exception('failded to login');
      }
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: hexToColor("#E0E0E0"),
          accentColor: hexToColor("#EF4B57"),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/mypage': (context) => MyPage(),
        },
      ),
    );
  }
}
