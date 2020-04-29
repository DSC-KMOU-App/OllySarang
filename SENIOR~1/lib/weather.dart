import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:math' as Math;
import 'dart:core';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  @override
  State createState() => _WeatherStatefulWidget();
}

class _WeatherStatefulWidget extends State<Weather> {
  @override
  List weather = [];
  final double RE = 6371.00877; // 지구 반경(km)
  final double GRID = 5.0; // 격자 간격(km)
  final double SLAT1 = 30.0; // 투영 위도1(degree)
  final double SLAT2 = 60.0; // 투영 위도2(degree)
  final double OLON = 126.0; // 기준점 경도(degree)
  final double OLAT = 38.0; // 기준점 위도(degree)
  final double XO = 43; // 기준점 X좌표(GRID)
  final double YO = 136; // 기1준점 Y좌표(GRID)

// LCC DFS 좌표변환 ( code :
//          "toXY"(위경도->좌표, v1:위도, v2:경도),
//          "toLL"(좌표->위경도,v1:x, v2:y) )
// 출처: https://gist.github.com/fronteer-kr/14d7f779d52a21ac2f16

  Map<dynamic,dynamic> dfs_xy_conv(code, v1, v2) {
    print("실행 !!");
    var DEGRAD = Math.pi / 180.0;
    var RADDEG = 180.0 / Math.pi;

    var re = RE / GRID;
    var slat1 = SLAT1 * DEGRAD;
    var slat2 = SLAT2 * DEGRAD;
    var olon = OLON * DEGRAD;
    var olat = OLAT * DEGRAD;

    var sn = Math.tan(Math.pi * 0.25 + slat2 * 0.5) / Math.tan(Math.pi * 0.25 + slat1 * 0.5);
    sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
    var sf = Math.tan(Math.pi * 0.25 + slat1 * 0.5);
    sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
    var ro = Math.tan(Math.pi * 0.25 + olat * 0.5);
    ro = re * sf / Math.pow(ro, sn);
    var rs = {};
    var ra;
    var theta;
    if (code == "toXY") {
      rs['lat'] = v1;
      rs['lng'] = v2;
      ra = Math.tan(Math.pi * 0.25 + (v1) * DEGRAD * 0.5);
      ra = re * sf / Math.pow(ra, sn);
      theta = v2 * DEGRAD - olon;
      if (theta > Math.pi) theta -= 2.0 * Math.pi;
      if (theta < -Math.pi) theta += 2.0 * Math.pi;
      theta *= sn;
      rs['x'] = (ra * Math.sin(theta) + XO + 0.5).floor();
      rs['y'] = (ro - ra * Math.cos(theta) + YO + 0.5).floor();
    }

    print("rs: "+rs.toString());
    return rs;
  }

  Future<String> _getuserLocation() async{
    Location location = new Location();
    Map<dynamic,dynamic> conv;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        return "failed";
      }
    }

    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return "failed";
      }
    }

    _locationData = await location.getLocation();

    double lat = _locationData.latitude;
    double lng = _locationData.longitude;
    conv = dfs_xy_conv("toXY", lat, lng);
    print(conv.toString());
    return "nx="+conv["x"].toString()+"&ny="+conv["y"].toString();
  }
  Future<String> getUrl() async{
    int hour = DateTime.now().hour;
    int minute = DateTime.now().second;
    int nowYearnum = new DateTime.now().year;
    int nowMonthnum = new DateTime.now().month;
    int nowDatenum = new DateTime.now().day;
    // 1  2  3  4  5  6  7  8  9  10 11 12
    List<int> Month = [0,31,28,31,30,31,30,31,30,31,31,30,31];
    int k = 0;
    if(hour>=2&&hour<5){
      if(minute<=10) {
        nowDatenum--;
        if(nowDatenum==0){
          nowDatenum = Month[nowMonthnum--];
          if(nowMonthnum==0){
            nowYearnum--;
            nowMonthnum = 12;
            nowDatenum = 31;
          }
        }
        k = 7;
      }
      else k = 0;
    }
    else if(hour>=5&&hour<8){
      if(minute<=10) k = 0;
      else k = 1;
    }
    else if(hour>=8&&hour<11){
      if(minute<=10) k = 1;
      else k = 2;
    }
    else if(hour>=11&&hour<14){
      if(minute<=10) k = 2;
      else k = 3;
    }
    else if(hour>=14&&hour<17){
      if(minute<=10) k = 3;
      else k = 4;
    }
    else if(hour>=17&&hour<20){
      if(minute<=10) k = 4;
      else k = 5;
    }
    else if(hour>=20&&hour<23){
      if(minute<=10) k = 5;
      else k = 6;
    }
    else{
      nowDatenum--;
      if(nowDatenum==0){
        nowDatenum = Month[nowMonthnum--];
        if(nowMonthnum==0){
          nowYearnum--;
          nowMonthnum = 12;
          nowDatenum = 31;
        }
      }
      if(minute<=10) k = 6;
      else k = 7;
    }
    String nowYear = nowYearnum.toString();
    String nowMonth = "";
    if(nowMonthnum<10) nowMonth+="0";
    nowMonth += nowMonthnum.toString();
    String nowDate = "";
    if(nowDatenum<10) nowDate += "0";
    nowDate += nowDatenum.toString();
    String userlocation = await _getuserLocation();
    String now =  nowYear + nowMonth + nowDate;
    List<String> timelist = ['0200', '0500', '0800', '1100', '1400', '1700', '2000', '2300' ];
    String _serviceKey = 'mD9ZAU5KEnetwXC/rQ/B45VYMCn4nGCDe9ODAgYTncnrECrgjvE9zXsdfP1SbHy5ALCyQt6RN1FrStvAG27ixQ==';
    String time = timelist[k];
    String url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst?'
        'serviceKey='
        +_serviceKey+
        '&pageNo=1&numOfRows=15&dataType=JSON&base_date='
        +now+
        '&base_time='+time+
        '&'+userlocation;

    print(url);

    return url;

  }
  Future<List> getWeather(List data) async{
    List weatherlist = [];

    if(data.length==1){
      weatherlist.add({
        "title":Text ("오류",
            style: TextStyle(fontFamily: 'Gothic',fontSize: 20.0,color:Color.fromRGBO(84,55,41,1),fontWeight: FontWeight.bold)),
        "status":"다시 시도해 주세요",
        "iconname": Icon(Icons.error),
      });
    }
    else {
      var ptycategory = [' 비 안 와요', ' 비 내려요', ' 진눈깨비에요', ' 눈 내려요', ' 소나기에요'];
      List temp = [];
      for (int i = 0; i < 10; ++i) {
        var category = {
          "title": Text(""),
          "status": "",
          "iconname": Image.asset('images/sunny.png'),
        };
        if (data[i]["category"] == "POP") {
          category["title"] =  Text("비가 올 확률",
            style: TextStyle(fontFamily: 'Gothic', fontSize: 20.0,color: Color.fromRGBO(84,55,41,1), fontWeight: FontWeight.bold),);
          category["status"] = data[i]["fcstValue"].toString() + "%";
          category["iconname"] = Image.asset('images/rain.png');
        }
        else if (data[i]["category"] == "SKY") {
          category["title"] = Text("현재 하늘",
            style: TextStyle(fontSize: 20.0,color: Color.fromRGBO(84,55,41,1), fontWeight: FontWeight.bold),);
          int status = int.parse(data[i]['fcstValue']);
          String sky = "";
          if (status < 6) {
            sky = " 맑아요 😉";
            category["iconname"] = Image.asset('images/sunny.png');
          } else if (status < 9) {
            sky = " 구름 많아요 😮";
            category["iconname"] = Image.asset('images/cloudy.png');
          } else {
            sky = " 흐려요 😦";
            category["iconname"] = Image.asset('images/cloudsun.png');
          }
          category["status"] = sky;

        }
        else if (data[i]["category"] == "REH") {
          category["title"] = Text("습도",
            style: TextStyle(fontSize: 20.0,color: Color.fromRGBO(84,55,41,1), fontWeight: FontWeight.bold),);
          category["status"] = data[i]["fcstValue"].toString() + "%";
          category["iconname"] = Image.asset('images/humidity.png');
        }
        else if (data[i]["category"] == "T3H") {
          category["title"] = Text("기온",
            style: TextStyle(fontSize: 20.0,color: Color.fromRGBO(84,55,41,1), fontWeight: FontWeight.bold),);
          category["status"] = data[i]["fcstValue"].toString() + "℃";
          category["iconname"] = Image.asset('images/temperature.png');
        }
        else if (data[i]["category"] == "PTY") {
          int status = int.parse(data[i]["fcstValue"]);
          category["title"] = Text("현재 상태",
            style: TextStyle(fontSize: 20.0,color: Color.fromRGBO(84,55,41,1), fontWeight: FontWeight.bold),);
          category["iconname"] = Image.asset('images/today.png');
          category["status"] = ptycategory[status];
        }
        else {
          continue;
        }
        temp.add(category);
      }
      weatherlist.add(temp[3]);
      weatherlist.add(temp[1]);
      weatherlist.add(temp[4]);
      weatherlist.add(temp[2]);
      weatherlist.add(temp[0]);
    }

    return weatherlist;
  }
  Future<List> getData(String url) async {
    http.Response response = await http.get(
        url,
        headers: {"Accept":"application/json"});
    dynamic temp = jsonDecode(response.body);
    List data = [];
    if(temp["response"]["header"]["resultCode"]=="00")
      data = temp["response"]["body"]["items"]["item"];
    else
      data.add({"error":"error"});
    return data;
  }
  @override
  void initState(){
    super.initState();
    this.getUrl().then((url){
      this.getData(url).then((result){
        print(result);
        this.setState((){
          this.getWeather(result).then((weatherlist){
            this.weather = weatherlist;
          })
              .catchError((onError){
            print(onError);
          });
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return  Container(
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: weather == null ? 0 : weather.length,
        itemBuilder: (BuildContext context,int index){
          return new Card(
              color: index%2==1 ? Colors.amber[200] : Colors.deepOrange[200],
            child:ListTile(
              leading: Container(
                  width: 60.0,
                  height: 60.0,
                  child:weather[index]["iconname"]
              ),
              title: weather[index]["title"],
              subtitle: Text(weather[index]["status"],style: TextStyle(fontSize: 20)),
            ),
          );
        },
      ),
    );
  }
}