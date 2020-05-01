import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ollysarang/BasicPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

void main() {
  initializeDateFormatting().then((_) => runApp(Start()));
  Intl.defaultLocale = 'en_US';
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'OllySarang',
      theme: ThemeData(
        fontFamily: 'Gothic',
        primaryColor: Color.fromRGBO(245, 111, 87, 1),
      ),
      home: BasicPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}