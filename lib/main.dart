import 'package:EPOLICE/LoginPage.dart';
import 'package:EPOLICE/after_form_screen.dart';
import 'package:EPOLICE/demo_Login.dart';
import 'package:EPOLICE/Victim_block.dart';
import 'package:EPOLICE/nearby_police_screen.dart';

import 'package:EPOLICE/witness_block.dart';

import './homescreen.dart';
import './screens/complaint_screen.dart';

import './screens/information_screen.dart';

import './screens/status_screen.dart';
import './splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import './login.dart';

import './screens/demoFIr.dart';
import 'Victim_block.dart';

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
      title: 'E-POLICE',
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
        '/station': (ctx) => NearbyPolice(),
        '/homescreen': (ctx) => MyHomePage(),
        '/loginscreen': (ctx) => LoginPage(),
        '/firform': (ctx) => VictimBlock(),
        '/demologin': (ctx) => DemoLogin(),
        '/demofir': (ctx) => FirFormTab(),
        '/witness': (ctx) => WitnessBlock(),
        '/victim': (ctx) => VictimBlock(),
        '/afterform': (ctx) => AfterForm(),
      },
    );
  }
}
