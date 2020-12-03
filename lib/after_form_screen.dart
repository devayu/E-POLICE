import 'dart:io';
import 'package:printing/printing.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import './fir_form_firestore.dart';
import 'package:pdf/pdf.dart';

class AfterForm extends StatelessWidget {
  final pdf = pw.Document();
  writePdf(String vName, String wName, String wPhNum, String vPhNum) {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(30),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
            level: 0,
            child: pw.Text(
              "Date of FIR: " + FirFirestore().doF,
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Text(
            'Thank you for filling out the form.',
            style: pw.TextStyle(
              color: PdfColor.fromHex("194A6D"),
              fontSize: 40,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 30),
          pw.Text(
            'Your E-FIR has been generated with FIR Number: ' +
                FirFirestore().time,
            style: pw.TextStyle(
              fontSize: 35,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text(
              "Complainant's Name: " + wName,
              style: pw.TextStyle(
                fontSize: 30,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              "Phone Number: " + wPhNum,
              style: pw.TextStyle(
                fontSize: 30,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 20),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text(
              "Victim's Name: " + vName,
              style: pw.TextStyle(
                fontSize: 30,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              "Phone Number: " + vPhNum,
              style: pw.TextStyle(
                fontSize: 30,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ]),
          pw.SizedBox(height: 100),
          pw.Text(
            "Please save this file or FIR Number for checking the status of your FIR.",
            style: pw.TextStyle(
              color: PdfColors.red500,
              fontSize: 25,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ];
      },
    ));
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future savePdf() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String documentPath = docDirectory.path;

    File file = File('$documentPath/EFIR.pdf');

    file.writeAsBytesSync(pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.4), BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image: const AssetImage('assets/images/police_logo.png'),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Thank You for filling out the E-FIR",
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Your E-FIR has been generated with Case ID: " +
                          FirFirestore().time,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                    child: Text('PDF'),
                    onPressed: () async {
                      //writePdf();
                      // await savePdf();
                      // Directory docDirectory =
                      //     await getApplicationDocumentsDirectory();
                      // String documentPath = docDirectory.path;
                      // String path = '$documentPath/EFIR.pdf';
                    },
                  ),
                  RaisedButton(
                      child: Text('Save'),
                      onPressed: () async {
                        Printing.layoutPdf(
                            onLayout: (PdfPageFormat format) async =>
                                pdf.save());
                      }),
                  Container(
                    width: 150,
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/homescreen'));
                      },
                      child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Homescreen',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Icon(
                                Icons.home,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).popAndPushNamed('/status');
                      },
                      child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Check Status',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
