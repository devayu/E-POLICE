import 'package:EPOLICE/demo_Login.dart';
import 'package:EPOLICE/fir_form.dart';

import './homescreen.dart';
import './screens/complaint_screen.dart';

import './screens/information_screen.dart';

import './screens/status_screen.dart';
import './splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import './login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: TextTheme(headline1: TextStyle(fontFamily: 'Montserrat')),
          primaryColor: Hexcolor('#194A6D'),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Hexcolor('#F2F5F6'), //
          backgroundColor: Colors.white,
          fontFamily: 'Montserrat'),
      home: SplashScreen(),
      routes: {
        '/information': (ctx) => InformationScreen(),
        '/complaint': (ctx) => ComplaintScreen(),
        '/status': (ctx) => StatusScreen(),
        // '/station': (ctx) => NearbyPoliceStationScreen(),
        '/homescreen': (ctx) => MyHomePage(),
        '/loginscreen': (ctx) => LoginScreen(),
        '/firform': (ctx) => FirForm(),
        '/demologin': (ctx) => DemoLogin(),
      },
    );
  }
}
