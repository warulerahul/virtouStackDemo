import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtoustackdemo/splash_screen/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    /*
    * set Portrait Mode
    * */
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
