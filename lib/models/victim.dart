import 'package:flutter/foundation.dart';

class Victim {
  String id;
  String fname;
  String lname;
  String age;
  int phnumber;
  int alternateNumber;
  String address;
  String city;
  String state;
  int pincode;
  DateTime dateOfIncident;
  String natureIncident;

  String incidentDescription;

  Victim({
    @required this.address,
    @required this.age,
    this.alternateNumber,
    @required this.city,
    @required this.dateOfIncident,
    @required this.fname,
    @required this.id,
    @required this.incidentDescription,
    @required this.lname,
    this.natureIncident,
    @required this.phnumber,
    @required this.pincode,
    @required this.state,
  });
}
