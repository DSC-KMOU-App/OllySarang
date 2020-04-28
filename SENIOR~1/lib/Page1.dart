import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intent/intent.dart'as tent;
import 'package:intent/action.dart'as act;
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
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Color.fromRGBO(138, 192, 85, 1),
                child:FlatButton(
                  child: Image.asset('images/call.png'),
                  onPressed: (){//전화
                    tent.Intent()
                      ..setAction(act.Action.ACTION_DIAL)
                      ..startActivity().catchError((e) => print(e));
                  },
                ),
              ),
              Container(
                child:FlatButton(
                  color: Color.fromRGBO(115, 177, 244, 1),
                  child: Image.asset('images/message.png'),
                  onPressed: (){//문자
                    tent.Intent()
                      ..setAction(act.Action.ACTION_VIEW)
                      ..putExtra("sms_body", "The SMS text")
                      ..setType("vnd.android-dir/mms-sms")
                      ..startActivity().catchError((e) => print(e));
                  },
                ),
              ),
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
                color: Color.fromRGBO(245, 187, 69, 1),
                child:FlatButton(
                  child: Image.asset('images/contact.png'),
                    onPressed: (){//연락처
                      tent.Intent()
                        ..setAction(act.Action.ACTION_VIEW)
                        ..setData(Uri.parse("content://contacts/people/"))
                        ..startActivity().catchError((e) => print(e));
                    }
                ),
              ),
              Container(
                color: Color.fromRGBO(236,85,100,1),
                child:FlatButton(
                  child: Image.asset('images/camera.png'),
                  onPressed: (){
                    tent.Intent()
                      ..setAction(act.Action.ACTION_IMAGE_CAPTURE)
                      ..startActivity().catchError((e) => print(e));
                  },
                ),
              ),
              Container(
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