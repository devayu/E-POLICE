import 'package:flutter/foundation.dart';

class Witness {
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
  String relationWithVictim;
  String suspectName;
  String suspectDescription;

  String incidentDescription;

  Witness({
    @required this.address,
    @required this.age,
    this.alternateNumber,
    @required this.city,
    this.relationWithVictim,
    @required this.fname,
    @required this.id,
    @required this.incidentDescription,
    @required this.lname,
    this.suspectName,
    @required this.phnumber,
    @required this.pincode,
    @required this.state,
    this.suspectDescription,
  });
}
