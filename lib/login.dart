import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:flutter_otp/flutter_otp.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phNumber;
  int code;
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

//* new login block starts

  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();

  /// Sends the code to the specified phone number.
  Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential user) {
      setState(() {
        print(
            'Inside _sendCodeToPhoneNumber: signInWithPhoneNumber auto succeeded: $user');
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      setState(() {
        print(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print("code sent to " + phoneNumberController.text);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // void _signInWithPhoneNumber(String smsCode) async {
  //   await FirebaseAuth.instance
  //       .signInWithPhoneNumber(verificationId: verificationId, smsCode: smsCode)
  //       .then((UserCredential user) async {
  //     final UserCredential currentUser = await _auth.currentUser();
  //     assert(user.uid == currentUser.uid);
  //     print('signed in with phone number successful: user -> $user');
  //   });
  // }

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
                      controller: phoneNumberController,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.phone,
                      cursorColor: Theme.of(context).primaryColor,
                      textInputAction: TextInputAction.next,
                      // onChanged: (value) {
                      //   setState(() {
                      //     this.phNumber = value;
                      //   });
                      // },
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Phone number',
                        border: InputBorder.none,
                        labelStyle: TextStyle(fontWeight: FontWeight.normal),
                        contentPadding: EdgeInsets.all(10),
                      )),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(top: 30, left: 30, right: 10),
                        color: Colors.grey[300],
                        child: TextFormField(
                            controller: codeController,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              this.phNumber = value;
                            },
                            maxLength: 6,
                            decoration: InputDecoration(
                              counterText: '',
                              labelText: 'OTP',
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            )),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 30, right: 30),
                      color: Colors.grey[300],
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                        ),
                        onPressed: () {
                          _sendCodeToPhoneNumber();
                        },
                      ),
                    ),
                  ],
                ),
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
                      // onTap: () {
                      //   Navigator.of(context).pushNamed('/homescreen');
                      // },
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
                            //verfiyPhone();
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
                Align(
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      splashColor: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        width: 200,
                        child: ListTile(
                          onTap: () {
                            FlutterOtp().sendOtp(phNumber);
                          },
                          title: Text(
                            'Send Otp',
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
