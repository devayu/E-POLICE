import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class FirForm extends StatefulWidget {
  @override
  _FirFormState createState() => _FirFormState();
}

class _FirFormState extends State<FirForm> {
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

  final _formKey = GlobalKey<FormState>();
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

  bool checkedValue = false;

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
    return MaterialApp(
      home: GestureDetector(
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
              backgroundColor: Colors.white54,
              appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                title: Text(
                  'FILE E-FIR',
                  style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(20),
                        child: const Text(
                          "Victim's Detail",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
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
                                padding: EdgeInsets.only(left: 20),
                                width: 100,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixStyle:
                                            TextStyle(color: Colors.red),
                                        labelText: 'Age',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.text,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixStyle:
                                            TextStyle(color: Colors.red),
                                        labelText: 'First Name',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      )),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.text,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixStyle:
                                            TextStyle(color: Colors.red),
                                        labelText: 'Main Number',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      )),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: 'Alternate Number',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.text,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixStyle:
                                            TextStyle(color: Colors.red),
                                        labelText: 'City',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      )),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.text,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: 'State',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                            width: MediaQuery.of(context).size.width * .45,
                            height: 60,
                            child: Card(
                              color: Colors.grey[300],
                              child: TextFormField(
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
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                                color: Colors.grey[300],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: selectedDate == null
                                          ? Text(
                                              'No Date Chosen',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.red),
                                            )
                                          : Text(
                                              DateFormat.MMMd()
                                                      .format(selectedDate)
                                                      .toString() +
                                                  ' ' +
                                                  DateFormat.jm()
                                                      .format(currentTime)
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        presentDatePicker();
                                      },
                                      child: Text(
                                        'Choose Date',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    )
                                  ],
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
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),

                      //* ===========================================================
                      //* ANCHOR Witness's block Starts
                      //* ===========================================================

                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 30,
                          top: 20,
                        ),
                        child: Text(
                          "Witness's Detail",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
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
                                padding: EdgeInsets.only(left: 20),
                                width: 100,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixStyle:
                                            TextStyle(color: Colors.red),
                                        labelText: 'Age',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.text,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixStyle:
                                            TextStyle(color: Colors.red),
                                        labelText: 'First Name',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      )),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.text,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixStyle:
                                            TextStyle(color: Colors.red),
                                        labelText: 'Main Number',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      )),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: 'Alternate Number',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.text,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixStyle:
                                            TextStyle(color: Colors.red),
                                        suffixText: '*',
                                        labelText: 'City',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      )),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                width: MediaQuery.of(context).size.width * .45,
                                height: 60,
                                child: Card(
                                  color: Colors.grey[300],
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.text,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: 'State',
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                            width: MediaQuery.of(context).size.width * .45,
                            height: 60,
                            child: Card(
                              color: Colors.grey[300],
                              child: TextFormField(
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
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
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
                            if (checkedValue == false) {
                              Toast.show('Checkbox unchecked', context,
                                  duration: Toast.LENGTH_LONG);
                            }
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ), //!form column
                ),
              ),
            )),
      ),
    );
  }
}
