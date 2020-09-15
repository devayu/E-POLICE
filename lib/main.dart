import 'package:e_police/screens/complaint_screen.dart';
import 'package:e_police/screens/fir_screen.dart';
import 'package:e_police/screens/information_screen.dart';
import 'package:e_police/screens/nearby_policestation_screen.dart';
import 'package:e_police/screens/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'custom_icons_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Hexcolor('#194A6D'),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Hexcolor('#E7F6FB'),
          backgroundColor: Hexcolor('#F2F5F6'),
          fontFamily: 'Montserrat'),
      home: MyHomePage(),
      routes: {
        '/information': (ctx) => InformationScreen(),
        '/fir': (ctx) => FirScreen(),
        '/complaint': (ctx) => ComplaintScreen(),
        '/status': (ctx) => StatusScreen(),
        '/station': (ctx) => NearbyPoliceStationScreen(),
      },
    );
  }
}

Widget homeSectionBuilder(
    String imageLoc, String text, BuildContext context, String routeName) {
  return Card(
    elevation: 5,
    color: Theme.of(context).accentColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        width: 110,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imageLoc,
              height: 50,
              width: 50,
            ),
            AutoSizeText(
              text,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
              maxLines: 2,
              maxFontSize: 12,
            ),
          ],
        ),
      ),
    ),
  );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
          backgroundColor: Hexcolor('#F2F5F6'),
          appBar: AppBar(
            backgroundColor: Hexcolor('#F2F5F6'),
            title: Text(
              'E-POLICE',
              style: TextStyle(
                  color: Hexcolor('#194A6D'),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 35),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  homeSectionBuilder(
                      'assets/images/fir.png', 'File FIR', context, '/fir'),
                  homeSectionBuilder('assets/images/status.png',
                      'Check previous FIR status', context, '/status'),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  homeSectionBuilder('assets/images/complaint.png',
                      'Lodge Complaint', context, '/complaint'),
                  homeSectionBuilder('assets/images/station.png',
                      'Nearby Police Station', context, '/station'),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  homeSectionBuilder('assets/images/rules.png',
                      'Important Information', context, '/information')
                ],
              )
            ],
          )),
    );
  }
}
