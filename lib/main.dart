import 'package:flutter/material.dart';
import 'package:shop_app/modules/inbording_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Janna',
          primarySwatch: Colors.blue,
        ),
        home: OnBoardingScreen(),

    );
  }
}