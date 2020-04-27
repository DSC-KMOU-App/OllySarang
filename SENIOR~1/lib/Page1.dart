import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class Page1 extends StatelessWidget {
  static const String _title = '한글 바로가기';
  @override
  Widget build(BuildContext context) {
    return Page1StatefulWidget();
  }
}

class Page1StatefulWidget extends StatefulWidget {
  Page1StatefulWidget({Key key}) : super(key: key);

  @override
  _Page1StatefulWidgetState createState() => _Page1StatefulWidgetState();
}

class _Page1StatefulWidgetState extends State<Page1StatefulWidget> {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 90,
                color: Color.fromRGBO(138, 192, 85, 1),
                child:FlatButton(
                  child: Image.asset('images/call.png'),
                  onPressed: (){
                    print('call');},
                ),
              ),
              Container(
                height: 90,
                child:FlatButton(
                  color: Color.fromRGBO(115, 177, 244, 1),
                  child: Image.asset('images/message.png'),
                  onPressed: (){
                    print('message');},
                ),
              ),
              Container(
                height: 90,
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
                height: 90,
                color: Color.fromRGBO(245, 187, 69, 1),
                child:FlatButton(
                  child: Image.asset('images/contact.png'),
                  onPressed: (){
                    AppAvailability.launchApp("com.skt.prod.phonebook");
                    print('contact');
                  },
                ),
              ),
              Container(
                height: 90,
                color: Color.fromRGBO(236,85,100,1),
                child:FlatButton(
                  child: Image.asset('images/camera.png'),
                  onPressed: (){
                    print('camera');
                  },
                ),
              ),
              Container(
                height: 90,
                color: Color.fromRGBO(172, 146, 234, 1),
                child:FlatButton(
                  child: Image.asset('images/gallery.png'),
                  onPressed: (){
                    print('gallery');
                    AppAvailability.launchApp("com.google.android.apps.photos");
                  },
                ),
              ),
              Container(
                height: 90,
                color: Color.fromRGBO(158, 211, 106, 1),
                child:FlatButton(
                  child: Image.asset('images/band.png'),
                  onPressed: (){
                    AppAvailability.launchApp("com.nhn.android.band");
                    print('band');
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}
class AppAvailability {
  static const MethodChannel _channel =
  const MethodChannel('com.pichillilorenzo/flutter_appavailability');
  static Future<void> launchApp(String uri) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('uri', () => uri);
    if (Platform.isAndroid) {
      await _channel.invokeMethod("launchApp", args);
    }
    else if (Platform.isIOS) {
      bool appAvailable = await _channel.invokeMethod("launchApp", args);
      if (!appAvailable) {
        throw PlatformException(code: "", message: "App not found $uri");
      }
    }
  }
}