import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

//FIXME textfield floatingColor change
//FIXME change textfield focus
class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return MaterialApp(
      home: Scaffold(
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
                  Colors.white.withOpacity(0.08), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage('assets/images/police_logo.png'),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
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
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(30),
                color: Colors.grey[300],
                child: TextField(
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.datetime,
                  cursorColor: Theme.of(context).primaryColor,
                  maxLength: 10,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                    focusColor: Theme.of(context).primaryColor,
                    labelText: ('Enter Date of FIR  (DD/MM/YYYY)'),
                    labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              ButtonTheme(
                height: 40,
                minWidth: 150,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Check',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
