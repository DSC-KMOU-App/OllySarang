import 'package:flutter/material.dart';
import 'package:seniorapp/Page1_1.dart';

class Page1_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Page1_2StatefulWidget();
  }
}

class Page1_2StatefulWidget extends StatefulWidget {
  Page1_2StatefulWidget({Key key}) : super(key: key);

  @override
  _Page1_2StatefulWidgetState createState() => _Page1_2StatefulWidgetState();
}

class _Page1_2StatefulWidgetState extends State<Page1_2StatefulWidget> {
  void updateState() {
    print("Update State of FirstPage");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      left: true,
      right: true,
      child: Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: Color.fromRGBO(254,205,87,1),
                child:FlatButton(
                  child: Image.asset('images/kakao.png'),
                  onPressed: (){
                    AppAvailability.launchApp("com.kakao.talk");
                    print('kakao');
                  },
                ),
              ),
              Container(
                color: Color.fromRGBO(128, 203, 196, 1),
                child:FlatButton(
                  child: Image.asset('images/band.png'),
                  onPressed: (){
                    AppAvailability.launchApp("com.nhn.android.band");
                    print('band');
                  },
                ),
              ),
              Container(
                color: Color.fromRGBO(244,67,54,1),
                child:FlatButton(
                  child: Image.asset('images/youtube.png'),
                  onPressed: (){
                    AppAvailability.launchApp("com.google.android.youtube");
                    print('youtube');
                  },
                ),
              ),
              Container(
                color: Color.fromRGBO(45,180,0,1),
                child:FlatButton(
                  child: Image.asset("images/naver.png"),
                  onPressed: (){
                    AppAvailability.launchApp("com.nhn.android.search");
                    print('naver');
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}