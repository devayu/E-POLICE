import 'package:flutter/material.dart';
import 'dart:async';

class SplashButtonScreen extends StatefulWidget {
  @override
  _SplashButtonScreenState createState() => new _SplashButtonScreenState();
}

class _SplashButtonScreenState extends State<SplashButtonScreen> {
  // startTime() async {
  //   var _duration = new Duration(seconds: 5);
  //   return new Timer(_duration, navigationPage);
  // }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/homescreen');
  }

  @override
  // void initState() {
  //   super.initState();
  //   startTime();
  // }
  //TODO Splash screen button animation and Welcome screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 250,
                    height: 250,
                    child: Image.asset('assets/images/police.png')),
                Text(
                  'E-POLICE',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                Container(
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: RaisedButton(
                    elevation: 5,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      navigationPage();
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
