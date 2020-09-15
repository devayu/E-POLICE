import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(
              'Important Information',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: TabBar(
              labelColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
              unselectedLabelColor: Color.fromRGBO(25, 74, 109, 120),
              unselectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
              tabs: [
                Tab(
                  text: 'Laws and Rules',
                ),
                Tab(
                  text: 'Helpline Numbers',
                ),
              ],
            ),
            // title: Text(
            //   'Important Information',
            //   textAlign: TextAlign.center,
            // ),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
