import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'fir_form_firestore.dart';
import 'dart:math';

import 'package:hexcolor/hexcolor.dart';

class VictimBlock extends StatefulWidget {
  @override
  _VictimBlockState createState() => _VictimBlockState();
}

class _VictimBlockState extends State<VictimBlock> {
  PickedFile image;
  var imageFile;
  Future getImage() async {
    PickedFile userImage;
    {
      userImage = (await ImagePicker().getImage(source: ImageSource.camera));
      setState(() {
        image = userImage;
        imageFile = File(userImage.path);
      });
    }
  }

  void _showDialog(int caseNO) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Proceed towards next step ?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: new Text(
            'Changes cannot be made after you proceed.',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "NO",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text(
                "YES",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  FirFirestore().phNum = vicMainNum.text;
                });
                obj.victim(
                  vicFname: vicFname.text,
                  vicLname: vicLname.text,
                  vicAge: vicAge.text,
                  vicStrAdd: vicStrAdd.text,
                  vicCity: vicCity.text,
                  vicState: vicState.text,
                  vicPinCode: vicPinCode.text,
                  nature: nature.text,
                  incidentDes: incidentDes.text,
                  vicMainNum: vicMainNum.text,
                  vicAltNum: vicAltNum.text,
                  pickedDate: selectedDate,
                );
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/witness');
              },
            )
          ],
        );
      },
    );
  }

  DateTime selectedDate;
  DateTime currentTime = DateTime.now();
  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2030))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
        currentTime = DateTime.now();
        // String datePicked = DateFormat.MMMd().format(selectedDate).toString();
      });
    });
  }

  FirFirestore obj = new FirFirestore();

  final _formKey = GlobalKey<FormState>();

  bool checkedValue = false;

  TextEditingController vicFname = new TextEditingController();
  TextEditingController vicLname = new TextEditingController();
  TextEditingController vicMainNum = new TextEditingController();
  TextEditingController vicAltNum = new TextEditingController();
  TextEditingController vicStrAdd = new TextEditingController();
  TextEditingController vicCity = new TextEditingController();
  TextEditingController vicState = new TextEditingController();
  TextEditingController vicPinCode = new TextEditingController();
  TextEditingController nature = new TextEditingController();
  TextEditingController incidentDes = new TextEditingController();
  TextEditingController vicAge = new TextEditingController();

  Widget titleBuilder(String name) {
    return RichText(
      text: TextSpan(
          text: name,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.black),
          children: [
            TextSpan(
              text: ' * ',
              style: TextStyle(color: Colors.red, fontSize: 16.0),
            ),
            TextSpan(
              text: ' : ',
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(1), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: const AssetImage('assets/images/police_logo.png'),
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Hexcolor('#F2F5F6'),
              title: Text(
                'FILE FIR',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 35),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.white54,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        "Victim's Detail",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 30),
                                child: titleBuilder('Age')),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicAge,
                                    validator: (value) {
                                      if (value.isEmpty) return '@required';
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'Age',
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2)),
                                      errorStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5)),
                              width: 100,
                              height: 100,
                              //color: Colors.red,
                              child: image == null
                                  ? IconButton(
                                      onPressed: () {
                                        getImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 40,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        child: Stack(
                                          fit: StackFit.expand,
                                          alignment: Alignment.center,
                                          children: [
                                            Image.file(
                                              imageFile,
                                              fit: BoxFit.cover,
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.refresh,
                                                  color: Colors.white70,
                                                ),
                                                onPressed: () {
                                                  getImage();
                                                }),
                                          ],
                                        ),
                                      ),
                                    )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Full Name')),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '@required';
                                      }
                                    },
                                    controller: vicFname,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'First Name',
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2)),
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicLname,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Phone Number')),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicMainNum,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'Main Number',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicAltNum,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Alternate Number',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Address')),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: vicStrAdd,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.multiline,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  labelText: 'Street Address',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicCity,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'City',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicState,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width * .5,
                          height: 60,
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: vicPinCode,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Pin Code',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Date and Time of FIR')),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .5,
                                padding: EdgeInsets.only(left: 20),
                                child: Card(
                                    color: Colors.grey[300],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: selectedDate == null
                                              ? Text(
                                                  'Choose Date',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Text(
                                                  DateFormat.MMMd()
                                                      .format(selectedDate)
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Montserrat',
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            presentDatePicker();
                                          },
                                          icon: Icon(
                                            Icons.calendar_today,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .5,
                                padding: EdgeInsets.only(right: 20),
                                child: Card(
                                    color: Colors.grey[300],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 40,
                                          child: TextField(
                                            maxLength: 2,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(1.5),
                                              hintText: 'HH',
                                              counterText: '',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 40,
                                          child: TextField(
                                            maxLength: 2,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(1.5),
                                              hintText: 'MM',
                                              counterText: '',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'Nature of Incident :',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: nature,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.multiline,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Incident Description')),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: incidentDes,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.multiline,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Tell us about the incident...',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 150,
                          height: 50,
                          child: InkWell(
                            onTap: () {
                              Random random = new Random();

                              int randomNumber = random.nextInt(100) + 100;
                              _showDialog(randomNumber);
                            },
                            child: Card(
                                color: Theme.of(context).primaryColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Proceed',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ],
                                )),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),

                    // WitnessBlock(
                    //   vicFName: vicFname.text,
                    //   vicLName: vicLname.text,
                    // ),
                  ],
                ), //!form column
              ),
            ),
          )),
    );
  }
}
