import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'package:EPOLICE/progess.dart';

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

  final _formKey = GlobalKey<FormState>();
  void fieldValidator(BuildContext context) {
    setState(() {
      firNum = firNumberController.text;
      firDate = selectedDate.toString();
    });

    if (firNum.isEmpty) {
      Toast.show('Fields not filled', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);

      print(firNum);

      validate = false;
    } else if (firDate == null) {
      Toast.show('not filled', context, gravity: Toast.BOTTOM);
      print(firDate);
    } else {
      Toast.show(' filled', context, gravity: Toast.BOTTOM);
    }
  }

  bool progress;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      primary: Theme.of(context).primaryColor,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'CHECK STATUS',
              style: TextStyle(
                  fontSize: 25,
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
                    Colors.white.withOpacity(0.1), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: AssetImage('assets/images/police_logo.png'),
              ),
            ),
            child: Form(
              key: _formKey,
              child: progress == true
                  ? Container(
                      child: Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'FIR Number: ' + firNumberController.text,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        ProgressScreen(firNumberController.text),
                      ]),
                    )
                  : Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                          color: Colors.grey[200],
                          child: TextFormField(
                            controller: firNumberController,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            autofocus: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return '@required';
                              }
                            },
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2)),
                              labelText: ('Enter FIR Number'),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          height: 40,
                          minWidth: 150,
                          child: ElevatedButton(
                            style:raisedButtonStyle,

                            child: const Text(
                              'Check',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (firNumberController.text.isEmpty) {
                                setState(() {
                                  progress = false;
                                });
                              } else
                                setState(() {
                                  progress = true;
                                });

                              setState(() {
                                if (_formKey.currentState.validate()) {}
                              });
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
