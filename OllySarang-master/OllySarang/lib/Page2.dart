import 'package:flutter/material.dart';
import 'package:ollysarang/weather.dart';
import 'package:ollysarang/newclock.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Page2StatefulWidget();
  }
}

class Page2StatefulWidget extends StatefulWidget {
  Page2StatefulWidget({Key key}) : super(key: key);

  @override
  _Page2StatefulWidgetState createState() => _Page2StatefulWidgetState();
}

class _Page2StatefulWidgetState extends State<Page2StatefulWidget> {
  @override
  void initState(){

  }

  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      left: true,
      right: true,
      child: Column(
        children: <Widget>[
          Row(
              children: <Widget>[
                SizedBox(width:10),
                Container(
                  alignment: Alignment(0,5),
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.check_circle),
                      SizedBox(width:10),
                      Text("Current Time"),
                    ],
                  ),
                ),
              ]
          ),
          Container(
            constraints: BoxConstraints.expand(
              height: 130.0,
            ),
            alignment: Alignment(0,0),
            height: 100,
            child: Wookieclock(),
          ),
          Row(
              children: <Widget>[
                SizedBox(width:10),
                Container(
                  alignment: Alignment(0,0),
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.check_circle),
                      SizedBox(width:10),
                      Text("Current Climate"),
                    ],
                  ),
                ),
              ]
          ),
          SizedBox(height: 10),
          Flexible(child: Weather()),
        ],
      ),
    );

  }
}