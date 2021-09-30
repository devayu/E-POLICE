import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNumber, verificationId;
  String otp, authStatus = "";
  Color mainColor = Color(0xff194A6D);
  Color secondaryColor = Color(0xffF2F5F6);

  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        print(authException);
        setState(() {
          authStatus = "Authentication failed";
        });
      },
      codeSent: (String verId, [int forceCodeResent]) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }

  otpDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Enter your OTP'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: secondaryColor,
              child: TextFormField(
                autofocus: true,
                  decoration: InputDecoration(border: InputBorder.none),
                  onChanged: (value) {
                    otp = value;
                  },
                ),
              ),
            ),
            // : EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel', style: TextStyle(color: Colors.red)),
              ),
              FlatButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                  signIn(otp);
                },
                child: Text(
                  'Submit',
                ),
              ),
            ],
          );
        });
  }

  Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ));
    User user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushNamed('/homescreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color col= Color(0xff0677BD);
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
          backgroundColor: Colors.white54,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 30,
                  ),
                  child: Text(
                    'WELCOME',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: col),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 35),
                  child: Text(
                    'SIGN IN TO CONTINUE',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.phone_iphone,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Enter Your Phone Number",
                          fillColor: Colors.white70),
                      onChanged: (value) {
                        phoneNumber = "+91" + value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      phoneNumber == null ? null : verifyPhoneNumber(context);
                    },
                    child: Text(
                      "Generate OTP",
                      style: TextStyle(color: Colors.white),
                    ),
                    elevation: 7.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                // Align(
                //   alignment: Alignment.center,
                //   child: ElevatedButton(
                //
                //     onPressed: () {
                //       Navigator.of(context).pushNamed('/homescreen');
                //     },
                //     child: Text(
                //       "Skip",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    authStatus == "" ? "" : authStatus,
                    style: TextStyle(
                        color: authStatus.contains("fail") ||
                                authStatus.contains("TIMEOUT")
                            ? Colors.red
                            : Colors.green),
                  ),
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
