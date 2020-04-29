import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seniorapp/BasicPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting().then((_) => runApp(Start()));
  Intl.defaultLocale = 'ko_KR';
}

class Start extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '올리 사랑',
      theme: ThemeData(
        fontFamily: 'Gothic',
        primaryColor: Color.fromRGBO(245, 111, 87, 1)  ,
      ),
      home: BasicPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

