import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ollysarang/Page1_1.dart';
import 'package:ollysarang/Page1_2.dart';
import 'package:ollysarang/Page2.dart';
import 'package:ollysarang/Page3.dart';

class BasicPage extends StatefulWidget{
  BasicPage({Key key,Title title}):super(key:key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage>{
  int _currentindex = 0;
  final List<Widget> _screen = [Page1_1(),Page1_2(),Page2(),Page3()];
  void _onTap(int index){
    setState((){
      _currentindex = index;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: Icon(Icons.people),
        title: Text("올리사랑",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
      ),
      body: _screen[_currentindex],
      bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 5.0,
          onTap: _onTap,
          currentIndex: _currentindex,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.looks_one),
              title: Text('홈 1'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.looks_two),
              title: Text('홈 2'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny),
              title: Text('날씨'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              title: Text('할일'),
            ),
          ]),
    );
  }
}