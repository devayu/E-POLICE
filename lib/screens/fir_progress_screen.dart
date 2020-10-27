import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FirProgressScreen extends StatefulWidget {
  String caseID;
  FirProgressScreen(this.caseID);
  @override
  _FirProgressScreenState createState() => _FirProgressScreenState(this.caseID);
}

TextEditingController progressName = new TextEditingController();

class _FirProgressScreenState extends State<FirProgressScreen> {
  String caseID;
  _FirProgressScreenState(this.caseID);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(1), BlendMode.dstATop),
            fit: BoxFit.cover,
            image: const AssetImage('assets/images/police_logo.png'),
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white54,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(
              'PROGRESS',
              style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: StreamBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('Loading');
                return Column(
                  children: [
                    LinearPercentIndicator(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      animation: true,
                      width: MediaQuery.of(context).size.width,
                      lineHeight: 20.0,
                      center: Text(
                          snapshot.data.documents[0]['progress']
                              .toString()
                              .toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500)),
                      animationDuration: 2000,
                      percent: 1
                      // progressCheck(snapshot.data.documents[0]['progress']),
                      ,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.redAccent,
                    )
                  ],
                );
              },
              stream: FirebaseFirestore.instance
                  .collection('Form Details')
                  .doc(caseID)
                  .collection('Progress')
                  .snapshots(),
            ),
          ),
        ),
      ),
    );
  }
}
