import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  String firNum;
  String firDate;
  bool validate = true;
  TextEditingController firNumberController = new TextEditingController();

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
      });
    });
  }

  void fieldValidator(BuildContext context) {
    setState(() {
      firNum = firNumberController.text;
      firDate = selectedDate.toString();
    });

    if (firNum.isEmpty && firDate.isEmpty) {
      Toast.show('Fields not filled', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      print(firDate);
      print(firNum);
      setState(() {
        validate = false;
      });
    } else {
      Toast.show('Working', context, gravity: Toast.CENTER);
      print('date' + firDate);
      print('num' + firNum);
    }
  }

  @override
  Widget build(BuildContext context) {
    //MediaQueryData queryData;
    //queryData = MediaQuery.of(context);

    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(
              'CHECK STATUS',
              style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(.5), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: const AssetImage('assets/images/police_logo.png'),
              ),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  color: Colors.grey[300],
                  child: TextField(
                    controller: firNumberController,
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: ('Enter FIR Number'),
                      labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                // Card(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)),
                //   margin: EdgeInsets.all(30),
                //   color: Colors.grey[300],
                //   child: TextField(
                //     controller: firDateController,
                //     style: TextStyle(
                //         fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                //     keyboardType: TextInputType.datetime,
                //     cursorColor: Theme.of(context).primaryColor,
                //     maxLength: 10,
                //     decoration: InputDecoration(
                //       counterText: '',
                //       contentPadding: EdgeInsets.all(10),
                //       border: InputBorder.none,
                //       focusColor: Theme.of(context).primaryColor,
                //       labelText: ('Enter Date of FIR  (DD/MM/YYYY)'),
                //       labelStyle: TextStyle(
                //           color: Theme.of(context).primaryColor,
                //           fontWeight: FontWeight.normal),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 500,
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.grey[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                            ),
                            child: selectedDate == null
                                ? Container(
                                    width: 340,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Choose FIR Date',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              color: Colors.red),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.calendar_today,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            presentDatePicker();
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: 340,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat.yMMMd()
                                              .format(selectedDate)
                                              .toString(),
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedDate = null;
                                            });
                                          },
                                          icon: Icon(Icons.cancel),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  height: 40,
                  minWidth: 150,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      'Check',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      fieldValidator(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
