import 'package:flutter/material.dart';
import 'package:seniorapp/BasicPage.dart';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Gothic',
        primaryColor: Color.fromRGBO(245, 111, 87, 1)  ,
      ),
      home: BasicPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

