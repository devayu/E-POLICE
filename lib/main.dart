import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'E-POLICE',
              style: TextStyle(
                  color: Hexcolor('#194A6D'),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 35),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    width: 100,
                    height: 95,
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      icon: Image.asset('assets/images/status.png'),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
