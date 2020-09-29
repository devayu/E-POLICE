import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.08), BlendMode.dstATop),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/police_logo.png'),
          ),
        ),
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
              child: TextField(
                  onEditingComplete: () {
                    print('done');
                  },
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).primaryColor,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) {},
                  maxLength: 10,
                  decoration: InputDecoration(
                    counterText: '',
                    labelText: 'Phone number',
                    border: InputBorder.none,
                    labelStyle: TextStyle(fontWeight: FontWeight.normal),
                    contentPadding: EdgeInsets.all(10),
                  )),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(top: 30, left: 30, right: 30),
              color: Colors.grey[300],
              child: TextField(
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).primaryColor,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) {},
                  maxLength: 4,
                  decoration: InputDecoration(
                    counterText: '',
                    labelText: 'OTP',
                    labelStyle: TextStyle(fontWeight: FontWeight.normal),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  )),
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
                      title: Text(
                        'Proceed',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}
