import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import './fir_form_firestore.dart';

import 'package:hexcolor/hexcolor.dart';

class WitnessBlock extends StatefulWidget {
  @override
  _WitnessBlockState createState() => _WitnessBlockState();
}

class _WitnessBlockState extends State<WitnessBlock> {
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

  FirFirestore obj = new FirFirestore();

  final _formKey = GlobalKey<FormState>();

  void _showDialog(String caseID) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Confirm EFIR?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: new Text(
            'Changes cannot be made after you confirm.',
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
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/afterform');
              },
            )
          ],
        );
      },
    );
  }

  bool checkedValue = false;

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                        controller: witAge,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                        controller: witFname,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: 'Last Name',
                                          labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                        controller: witMainNum,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: 'Alternate Number',
                                          labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                        controller: witCity,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                        controller: witState,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                    controller: witPinCode,
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
                              FocusScope.of(context).unfocus();

                              obj.witness(
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
                              );
                              obj.progress();
                              if (_formKey.currentState
                                  .validate()) if (checkedValue == false) {
                                Toast.show('Checkbox unchecked', context,
                                    duration: Toast.LENGTH_LONG);
                              } else {
                                _showDialog(FirFirestore().time);
                              }
                            },
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ), //!form column
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
