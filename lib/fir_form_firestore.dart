import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirFirestore {
  String time = DateTime.now().day.toString() +
      DateTime.now().month.toString() +
      DateTime.now().hour.toString() +
      DateTime.now().minute.toString();
  String vName;

  String doF = DateTime.now().day.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().year.toString();

  String phNum;

  Future<void> victim({
    String vicFname,
    String vicLname,
    DateTime pickedDate,
    String vicMainNum,
    String vicAltNum,
    String vicStrAdd,
    String vicCity,
    String vicState,
    String vicPinCode,
    String vicAge,
    String nature,
    String incidentDes,
    String witFname,
    String witLname,
    String witMainNum,
    String witAltNum,
    String witStrAdd,
    String witCity,
    String witState,
    String witPinCode,
    String witAge,
    String relationWith,
    String susName,
    String susDesc,
    var imageFile,
  }) async {
    String caseTitle = time;
    String docTitle = caseTitle;
    CollectionReference users =
        FirebaseFirestore.instance.collection('Form Details');

    users.doc(docTitle).collection('Victim').doc().set({
      'First Name': vicFname,
      'Last Name': vicLname,
      'Age': vicAge,
      'Main Number': vicMainNum,
      'Alternate Number': vicAltNum,
      'Street Address': vicStrAdd,
      'City': vicCity,
      'State': vicState,
      'Pin-Code': vicPinCode,
      'Nature of Incident': nature,
      'Incident Description': incidentDes,
    });
    users.doc(docTitle).collection('Witness').doc().set({
      'First Name': witFname,
      'Last Name': witLname,
      'Age': witAge,
      'Main Number': witMainNum,
      'Alternate Number': witAltNum,
      'Street Address': witStrAdd,
      'City': witCity,
      'State': witState,
      'Pin-Code': witPinCode,
      'Relationship with victim': relationWith,
      'Suspect Name': susName,
      'Suspect Description': susDesc,
    });
    final storage = FirebaseStorage.instance;
    var snapshot =
        await storage.ref().child('FIR Number:' + docTitle).putFile(imageFile);

    var downloadURL = snapshot.ref.getDownloadURL();
  }

  Future<void> witness({
    String witFname,
    String witLname,
    String witMainNum,
    String witAltNum,
    String witStrAdd,
    String witCity,
    String witState,
    String witPinCode,
    String witAge,
    String relationWith,
    String susName,
    String susDesc,
  }) async {
    String caseTitle = time;
    String docTitle = caseTitle;
    CollectionReference users =
        FirebaseFirestore.instance.collection('Form Details');

    users.doc(docTitle).collection('Witness').doc().set({
      'First Name': witFname,
      'Last Name': witLname,
      'Age': witAge,
      'Main Number': witMainNum,
      'Alternate Number': witAltNum,
      'Street Address': witStrAdd,
      'City': witCity,
      'State': witState,
      'Pin-Code': witPinCode,
      'Relationship with victim': relationWith,
      'Suspect Name': susName,
      'Suspect Description': susDesc,
    });
  }

  Future<void> progress() async {
    String docTitle = time;
    CollectionReference users =
        FirebaseFirestore.instance.collection('Form Details');
    users.doc(docTitle).collection('Progress').doc().set({
      'progress': 'sent',
      'Name': '',
      'Email': '',
    });
  }
}
