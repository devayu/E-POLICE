import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  DateTime selectedDate;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    DateTime selectedDate = DateTime.now();

    //TODO Datepicker implementation

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
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
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Card(
              margin: EdgeInsets.only(top: 30, left: 30, right: 30),
              color: Colors.grey[300],
              elevation: 5,
              child: TextField(
                style: TextStyle(fontFamily: 'Montserrat'),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter FIR Number',
                    hintStyle: TextStyle(fontFamily: 'Montserrat')),
              ),
            ),
            Card(
              margin: EdgeInsets.all(30),
              color: Colors.grey[300],
              elevation: 5,
              child: TextField(
                style: TextStyle(fontFamily: 'Montserrat'),
                decoration: InputDecoration(
                    hintText: 'Enter Date of FIR   (DD/MM/YYYY)',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                    hintStyle: TextStyle(fontFamily: 'Montserrat')),
              ),
            ),
            RaisedButton(
              elevation: 5,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Check',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
