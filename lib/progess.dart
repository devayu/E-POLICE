import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressScreen extends StatefulWidget {
  String caseID;
  ProgressScreen(this.caseID);
  @override
  _ProgressScreenState createState() => _ProgressScreenState(this.caseID);
}

double progressCheck(String progress) {
  var percent;

  if (progress == 'sent') {
    percent = 0.25;
  } else if (progress == 'review') {
    percent = 0.5;
  } else {
    percent = 1.0;
  }

  return percent;
}

String desc(double percent) {
  String description;
  if (percent == 0.25) {
    description = 'Your FIR has been sent. ';
  } else if (percent == 0.5) {
    description = 'Your FIR is being reviewed by the concerned authority.';
  } else {
    description = 'Your case has been closed.';
  }

  return description;
}

TextEditingController progressName = new TextEditingController();

class _ProgressScreenState extends State<ProgressScreen> {
  String caseID;
  _ProgressScreenState(this.caseID);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading');
          return Column(
            children: [
              snapshot.data.documents[0]['progress'].toString() == 'sent' ||
                      snapshot.data.documents[0]['progress'].toString() ==
                          'completed'
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Case has been assigned to:',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text('Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                  snapshot.data.documents[0]['Name']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Email ID',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                  snapshot.data.documents[0]['Email']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              LinearPercentIndicator(
                padding: EdgeInsets.only(left: 25, right: 25),
                animation: true,
                width: MediaQuery.of(context).size.width,
                lineHeight: 15.0,
                center: Text(
                    snapshot.data.documents[0]['progress']
                        .toString()
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500)),
                animationDuration: 1500,
                percent: progressCheck(snapshot.data.documents[0]['progress']),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.redAccent,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  desc(progressCheck(
                      snapshot.data.documents[0]['progress'].toString())),
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
            ],
          );
        },
        stream: FirebaseFirestore.instance
            .collection('Form Details')
            .doc(caseID)
            .collection('Progress')
            .snapshots(),
      ),
    );
  }
}
