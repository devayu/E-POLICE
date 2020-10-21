import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phNumber;
  String code;
  String smssent;
  String verificationId;

  get verifiedSuccess => null;

  Future<void> verfiyPhone() async {
    String phoneNum = '+91' + phNumber;
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess =
        (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
    };
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNum,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future<bool> smsCodeDialoge(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter OTP'),
            content: TextField(
              onChanged: (value) {
                this.smssent = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  var user = FirebaseAuth.instance.currentUser;
                  {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushReplacementNamed('/loginscreen');
                    } else {
                      Navigator.of(context).pop();
                      signIn(smssent);
                    }
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.of(context).pushReplacementNamed('/homescreen');
    }).catchError((e) {
      Navigator.of(context).pop();
      Toast.show('Invalid Code', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      print(e);
    });
  }

  final _loginFormKey = GlobalKey<FormState>();
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
            image: AssetImage('assets/images/police_logo.png'),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white54,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, left: 30),
                  child: Text(
                    'WELCOME',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Hexcolor('#0677BD')),
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
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  color: Colors.grey[300],
                  child: TextFormField(
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.phone,
                      cursorColor: Theme.of(context).primaryColor,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          this.phNumber = value;
                        });
                      },
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Phone number',
                        border: InputBorder.none,
                        labelStyle: TextStyle(fontWeight: FontWeight.normal),
                        contentPadding: EdgeInsets.all(10),
                      )),
                ),
                // Card(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)),
                //   margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                //   color: Colors.grey[300],
                //   child: TextFormField(
                //       style: TextStyle(
                //           fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                //       keyboardType: TextInputType.number,
                //       cursorColor: Theme.of(context).primaryColor,
                //       textInputAction: TextInputAction.next,
                //       onChanged: (value) {
                //         setState(() {
                //           this.code = value;
                //         });
                //       },
                //       maxLength: 6,
                //       decoration: InputDecoration(
                //         counterText: '',
                //         labelText: 'OTP',
                //         labelStyle: TextStyle(fontWeight: FontWeight.normal),
                //         border: InputBorder.none,
                //         contentPadding: EdgeInsets.all(10),
                //       )),
                // ),
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      splashColor: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.of(context).pushNamed('/homescreen');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        width: 200,
                        child: ListTile(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            verfiyPhone();
                          },
                          title: Text(
                            'Proceed',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.center,
                //   child: Card(
                //     elevation: 10,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20)),
                //     child: InkWell(
                //       splashColor: Colors.black,
                //       borderRadius: BorderRadius.circular(20),
                //       onTap: () {
                //         Navigator.of(context).pushNamed('/homescreen');
                //       },
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Theme.of(context).primaryColor,
                //         ),
                //         alignment: Alignment.center,
                //         width: 200,
                //         child: ListTile(
                //           onTap: () {
                //             verfiyPhone();
                //           },
                //           title: Text(
                //             'Testing Skip',
                //             style: TextStyle(
                //                 color: Colors.white, fontWeight: FontWeight.bold),
                //           ),
                //           trailing: Icon(
                //             Icons.arrow_forward,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/homescreen');
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
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
