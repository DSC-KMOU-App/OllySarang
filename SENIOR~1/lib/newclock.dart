import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Wookieclock extends StatefulWidget {
  Wookieclock({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WookieclockState createState() => _WookieclockState();
}

class _WookieclockState extends State<Wookieclock> {
  String _timeString;
  bool isDisposed = false;

  String _formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMEd().addPattern('\n'"a hh시mm분ss초").format(dateTime);
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Text(
        _timeString,
        style: TextStyle(fontSize: 30.0,color:Color.fromRGBO(84,55,41,1),fontWeight: FontWeight.bold));
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if(!isDisposed) {
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }

  void dispose() {
    super.dispose();
    isDisposed = true;
  }


}
