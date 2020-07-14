import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:virtoustackdemo/home_screen/ui/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Productsans',
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Sign in with your facebook account",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Productsans',
                    color: Colors.white70,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 20.0,),
                /*isLoggedIn
                    ? openHomePage()
                    : */Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: RaisedButton(
                          color: Colors.blue[800],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text("Sign in With Facebook",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Productsans',
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,),
                              ),
                            ],
                          ),
                          onPressed: () {
                            loginWithFB();
                          },
                        ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
  * Method to login with Facebook Login
  * */
  loginWithFB() async {
    final result = await facebookLogin.logIn(['email']);

    /*
    * Check for login status
    * If loggedIn Navigate to HomeScreen
    * */
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        print("Profile:- " + profile.toString());
        setState(() {
          userProfile = profile;
          isLoggedIn = true;
        });
        openHomePage();
        break;
        /*
        * If cancelledByUser
        * */
      case FacebookLoginStatus.cancelledByUser:
        setState(() => isLoggedIn = false);
        print("FacebookLoginStatus.canclledByUser:- $FacebookLoginStatus.cancelledByUser");
        break;
        /*
        * If error occurred
        * */
      case FacebookLoginStatus.error:
        setState(() => isLoggedIn = false);
        print("FacebookLoginStatus.error:- $FacebookLoginStatus.error");
        break;
    }
  }

  /*
  * Method to logout from FaceBook Login
  * */
  logout() {
    facebookLogin.logOut();
    setState(() {
      isLoggedIn = false;
    });
  }

  /*
  * Method to Navigate to HomeScreen
  * */
  openHomePage()
  {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        ModalRoute.withName("")
    );
  }

}
