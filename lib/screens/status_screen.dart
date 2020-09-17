import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  DateTime selectedDate;
  _selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate = null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    //TODO Datepicker implementation

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
                onEditingComplete: () {
                  print('done');
                },
                style: TextStyle(fontFamily: 'Montserrat'),
                keyboardType: TextInputType.number,
                cursorColor: Theme.of(context).primaryColor,
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter FIR Number',
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black26)),
              ),
            ),
            Card(
              margin: EdgeInsets.all(30),
              color: Colors.grey[300],
              elevation: 5,
              child: TextField(
                style: TextStyle(fontFamily: 'Montserrat'),
                keyboardType: TextInputType.datetime,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                    hintText: 'Enter Date of FIR  (DD/MM/YYYY)',
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black26)),
              ),
            ),
            // Container(
            //   alignment: Alignment.centerRight,
            //   child: IconButton(
            //     padding: EdgeInsets.only(right: 30),
            //     icon: Icon(Icons.calendar_today),
            //     onPressed: () {
            //       _selectDate(context);
            //     },
            //   ),
            // ),
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
            ),
          ],
        ),
        //selectedDate=null? :Card(),
      ),
    );
  }
}
