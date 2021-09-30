import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
Color mainColor = Color(0xff194A6D);
Color secondaryColor = Color(0xffF2F5F6);
Widget homeSectionBuilder(
    String imageLoc, String text, BuildContext context, String routeName) {

  return Card(
    elevation: 5,
    color: secondaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      splashColor: mainColor,
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

Future<void> _logout() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print(e.toString());
  }
}

class MyHomePage extends StatelessWidget {
  Color col = Color(0xfF2F5F6);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
          elevation: 0,
          title: Text(
            'E-POLICE',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontSize: 35),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage('assets/images/police_logo.png'),
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  homeSectionBuilder(
                      'assets/images/fir.png', 'File FIR', context, '/victim'),
                  homeSectionBuilder('assets/images/status.png',
                      'Check previous FIR status', context, '/status'),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  homeSectionBuilder('assets/images/station.png',
                      'Nearby Police Station', context, '/station'),
                  // homeSectionBuilder('assets/images/complaint.png',
                  //     'Lodge Complaint', context, '/complaint'),
                  homeSectionBuilder('assets/images/rules.png',
                      'Important Information', context, '/information'),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: () {
            _logout();
            Navigator.of(context).pop();
          },
          child: Center(
            child: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
