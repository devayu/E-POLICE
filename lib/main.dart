import 'package:e_police/homescreen.dart';
import 'package:e_police/screens/complaint_screen.dart';
import 'package:e_police/screens/fir_screen.dart';
import 'package:e_police/screens/information_screen.dart';
import 'package:e_police/screens/nearby_policestation_screen.dart';
import 'package:e_police/screens/status_screen.dart';
import 'package:e_police/splash.dart';
import 'package:e_police/splashButton.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
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
          primaryColor: Hexcolor('#194A6D'),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Hexcolor('#F1FAFE'), //
          backgroundColor: Colors.white,
          fontFamily: 'Montserrat'),
      home: SplashScreen(),
      routes: {
        '/information': (ctx) => InformationScreen(),
        '/fir': (ctx) => FirScreen(),
        '/complaint': (ctx) => ComplaintScreen(),
        '/status': (ctx) => StatusScreen(),
        '/station': (ctx) => NearbyPoliceStationScreen(),
        '/homescreen': (ctx) => MyHomePage(),
        '/splashbutton': (ctx) => SplashButtonScreen(),
      },
    );
  }
}
