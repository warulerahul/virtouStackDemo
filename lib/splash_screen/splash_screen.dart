import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtoustackdemo/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    new Future.delayed(new Duration(seconds: 5), () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            ModalRoute.withName("")
        );
    });
  }

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return new Scaffold(
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              'assets/gif/image.gif',
              height: 150.0,
              width: 150.0,),
            SizedBox(height: 12.0,),
            singleTextHeader("Dog's Path", 26.0),

            SizedBox(height: 8.0,),
            singleTextHeader("by", 14.0),

            SizedBox(height: 8.0,),
            singleTextHeader("VirtouStack Software Pvt.Ltd", 20.0),
          ],
        ),
      ),
    );
  }
}

/*
  * Single Text to Show all Main text like titles
  * */
Widget singleTextHeader(String textHeader, double font) {
  return Container(
    margin: EdgeInsets.only(top: 7.0),
    child: Text(
      textHeader,
      style: TextStyle(
        fontSize: font, fontFamily: 'Productsans', color: Colors.white70, fontWeight: FontWeight.normal,),
    ),
  );
}

