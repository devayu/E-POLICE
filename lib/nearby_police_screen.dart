import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class NearbyPolice extends StatefulWidget {
  @override
  _NearbyPoliceState createState() => _NearbyPoliceState();
}

class _NearbyPoliceState extends State<NearbyPolice> {
  GoogleMapController mapController;
  String search = 'London';

  var currentLoc;
  bool mapToggle = false;
  bool isLocationServiceEnabled = false;

  LatLng curLoc;

  LatLng latlng = LatLng(
    -33.8670522,
    151.1957362,
  );
  Iterable markers = [];

  getData() async {
    try {
      final response = await http
          .get(
              'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${curLoc.latitude},${curLoc.longitude}&radius=4000&type=police&key=AIzaSyDMvd7rJjTABUTc6WYMeT9_kj5MkeB9xRI')
          .catchError((e) {
        print(e);
      });

      final int statusCode = response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        Map responseBody = json.decode(response.body);
        List results = responseBody["results"];

        Iterable _markers = Iterable.generate(10, (index) {
          Map result = results[index];
          Map location = result["geometry"]["location"];
          LatLng latLngMarker = LatLng(location["lat"], location["lng"]);

          return Marker(
            markerId: MarkerId("marker$index"),
            position: latLngMarker,
            infoWindow: InfoWindow(
                title: result["name"].toString(),
                snippet: result["vicinity"].toString()),
          );
        });

        setState(() {
          markers = _markers;
        });
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  Location loc;

  @override
  void initState() {
    super.initState();

    void checkPerm() async {
      bool isPermissionEnabled = await Geolocator.isLocationServiceEnabled();
    }

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      checkPerm();
      setState(() {
        currentLoc = value;
        mapToggle = true;
        curLoc = LatLng(currentLoc.latitude, currentLoc.longitude);
        loc = Location(lat: currentLoc.latitude, lng: currentLoc.longitude);
      });
    }).then((value) => getData());
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'POLICE STATIONS',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Container(
              child: mapToggle
                  ? GoogleMap(
                      markers: Set.from(markers),
                      buildingsEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      compassEnabled: true,
                      mapType: MapType.normal,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(currentLoc.latitude, currentLoc.longitude),
                        zoom: 13,
                      ),
                    )
                  : Center(
                      child: SpinKitCircle(
                        color: Colors.grey,
                        size: 50,
                      ),
                    ))
        ]),
      ),
    );
  }
}
