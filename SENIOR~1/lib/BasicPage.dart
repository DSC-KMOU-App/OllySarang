import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seniorapp/Page1.dart';
import 'package:seniorapp/Page2.dart';
import 'package:seniorapp/Page3.dart';

class BasicPage extends StatefulWidget{
  BasicPage({Key key,Title title}):super(key:key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage>{
  int _currentindex = 0;
  final List<Widget> _screen = [Page1(),Page2(),Page3()];
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
        title: Text("올리 사랑"),
      ),
      body: _screen[_currentindex],
      bottomNavigationBar: new BottomNavigationBar(
          elevation: 0.0,
          onTap: _onTap,
          currentIndex: _currentindex,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('홈 화면'),
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