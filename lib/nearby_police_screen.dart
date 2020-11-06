import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_google_places_api/flutter_google_places_api.dart';

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

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    NearbySearchResponse response = await NearbySearchRequest(
            key: 'AIzaSyDJ3E3KpjWSETVh18aJWN-R0WLH5DaG1bE',
            location: loc,
            radius: 10)
        .call()
        .catchError((e) {
      print(e);
    });

    print(response.toString());
  }

  Location loc;

  @override
  void initState() {
    // TODO: implement initState
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
        loc = Location(lat: currentLoc.latitude, lng: currentLoc.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'E-POLICE',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontSize: 35),
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Container(
              child: mapToggle
                  ? GoogleMap(
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
                        zoom: 15,
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
