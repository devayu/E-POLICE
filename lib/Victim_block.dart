import 'package:EPOLICE/after_form_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'fir_form_firestore.dart';

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

  void _showDialog(String caseNO) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Are you sure ?",
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
                  witFname: witFname.text,
                  witLname: witLname.text,
                  witAge: witAge.text,
                  witStrAdd: witStrAdd.text,
                  witCity: witCity.text,
                  witState: witState.text,
                  witPinCode: witPinCode.text,
                  relationWith: relationWith.text,
                  susDesc: susDes.text,
                  susName: susName.text,
                  witAltNum: witAltNum.text,
                  witMainNum: witMainNum.text,
                  imageFile: imageFile,
                );
                obj.progress();
                String victimFullName = vicFname.text + "" + vicLname.text;
                String witnessFullName = witFname.text + " " + witLname.text;
                odf.writePdf(
                    victimFullName.toUpperCase(),
                    witnessFullName.toUpperCase(),
                    witMainNum.text,
                    vicMainNum.text);

                
                Navigator.popUntil(context, ModalRoute.withName('/homescreen'));
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
      });
    });
  }

  AfterForm odf = new AfterForm();

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

  TextEditingController witFname = new TextEditingController();
  TextEditingController witLname = new TextEditingController();
  TextEditingController witMainNum = new TextEditingController();
  TextEditingController witAltNum = new TextEditingController();
  TextEditingController witStrAdd = new TextEditingController();
  TextEditingController witCity = new TextEditingController();
  TextEditingController witState = new TextEditingController();
  TextEditingController witPinCode = new TextEditingController();
  TextEditingController relationWith = new TextEditingController();
  TextEditingController susName = new TextEditingController();
  TextEditingController susDes = new TextEditingController();
  TextEditingController witAge = new TextEditingController();

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

    Color mainColor = Color(0xff194A6D);
    Color secondaryColor = Color(0xffF2F5F6);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.15), BlendMode.dstATop),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/police_logo.png'),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation:0,
            title: Text(
              'FILE FIR',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 25),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white54,
          body: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                              validator: (value) {
                                if (value.isEmpty) return '@required';
                              },
                              controller: vicMainNum,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              cursorColor: Theme.of(context).primaryColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                suffixStyle: TextStyle(color: Colors.red),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2)),
                                errorStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
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
                          validator: (value) {
                            if (value.isEmpty) return '@required';
                          },
                          controller: vicStrAdd,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.multiline,
                          cursorColor: Theme.of(context).primaryColor,
                          textInputAction: TextInputAction.next,
                          maxLines: 2,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            errorStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
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
                              validator: (value) {
                                if (value.isEmpty) return '@required';
                              },
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
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        width: MediaQuery.of(context).size.width * .5,
                        height: 60,
                        child: Card(
                          color: Colors.grey[300],
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) return '@required';
                              },
                              controller: vicState,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.text,
                              cursorColor: Theme.of(context).primaryColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'State',
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
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width * .5,
                    height: 60,
                    child: Card(
                      color: Colors.grey[300],
                      child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return '@required';
                          },
                          controller: vicPinCode,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          cursorColor: Theme.of(context).primaryColor,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Pin Code',
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
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
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 30),
                      child: titleBuilder('Date and Time of Incident')),
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
                                                fontWeight: FontWeight.bold,
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
                                        contentPadding: EdgeInsets.all(1.5),
                                        hintText: 'HH',
                                        counterText: '',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ':',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 40,
                                    child: TextField(
                                      maxLength: 2,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(1.5),
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
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
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
                          validator: (value) {
                            if (value.isEmpty) return '@required';
                          },
                          controller: incidentDes,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.multiline,
                          cursorColor: Theme.of(context).primaryColor,
                          textInputAction: TextInputAction.next,
                          maxLines: 5,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            errorStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
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
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  "Witness's Detail",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          padding: EdgeInsets.only(left: 20),
                          width: 100,
                          height: 60,
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) return '@required';
                                },
                                controller: witAge,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2)),
                                  errorStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                  suffixStyle: TextStyle(color: Colors.red),
                                  labelText: 'Age',
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
                                  if (value.isEmpty) return '@required';
                                },
                                controller: witFname,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.text,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2)),
                                  errorStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                  suffixStyle: TextStyle(color: Colors.red),
                                  labelText: 'First Name',
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
                                controller: witLname,
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
                                validator: (value) {
                                  if (value.isEmpty) return '@required';
                                },
                                controller: witMainNum,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2)),
                                  errorStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
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
                                controller: witAltNum,
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
                            validator: (value) {
                              if (value.isEmpty) return '@required';
                            },
                            controller: witStrAdd,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.multiline,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            maxLines: 2,
                            decoration: InputDecoration(
                              labelText: 'Street Address',
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2)),
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
                                  if (value.isEmpty) return '@required';
                                },
                                controller: witCity,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.text,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  suffixStyle: TextStyle(color: Colors.red),
                                  suffixText: '*',
                                  labelText: 'City',
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
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          width: MediaQuery.of(context).size.width * .5,
                          height: 60,
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) return '@required';
                                },
                                controller: witState,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.text,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'State',
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
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width * .5,
                      height: 60,
                      child: Card(
                        color: Colors.grey[300],
                        child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) return '@required';
                            },
                            controller: witPinCode,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Pin Code',
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2)),
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
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Relationship with victim :',
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
                            controller: relationWith,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.multiline,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              //labelText: 'Nature of Incident',
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
                      child: Text(
                        'Suspect Description :',
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
                            controller: susName,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.multiline,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            )),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        color: Colors.grey[300],
                        child: TextFormField(
                            controller: susDes,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.multiline,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            maxLines: 2,
                            decoration: InputDecoration(
                              labelText: 'Physical Description',
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
                CheckboxListTile(
                  checkColor: Colors.red,
                  activeColor: Colors.transparent,
                  subtitle: Text(
                    '*fields are required',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                  title: Text(
                    "*I certify that the above information is true and correct. I am totally aware that any legal action can be taken against me if the above provided information found out to be incorrect.",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                  value: checkedValue,
                  onChanged: (bool newValue) {
                    setState(() {
                      checkedValue = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      if (_formKey.currentState.validate()) if (checkedValue ==
                          false) {
                        Toast.show('Checkbox unchecked', context,
                            duration: Toast.LENGTH_LONG);
                      } else {
                      _showDialog(FirFirestore().time);
                      }
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ) //!form column
              ]),
            ]),
          )),
        ),
      ),
    );
  }
}
