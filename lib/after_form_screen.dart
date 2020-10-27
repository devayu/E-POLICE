import 'package:flutter/material.dart';
import './fir_form_firestore.dart';

class AfterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.4), BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image: const AssetImage('assets/images/police_logo.png'),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Thank You for filling out the E-FIR",
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Your E-FIR has been generated with Case ID: " +
                          FirFirestore().time,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/homescreen'));
                      },
                      child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Homescreen',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Icon(
                                Icons.home,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).popAndPushNamed('/status');
                      },
                      child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Check Status',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
