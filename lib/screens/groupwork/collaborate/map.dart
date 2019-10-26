import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CollaborateMapView extends StatefulWidget {
  CollaborateMapView({Key key}) : super(key: key);

  _CollaborateMapViewState createState() => _CollaborateMapViewState();
}

class _CollaborateMapViewState extends State<CollaborateMapView> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _jasin = CameraPosition(
    target: LatLng(2.3084, 102.4304),
    zoom: 9.00,
  );

  Future<void> _shareCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meet us"),
      ),
      body: Container(
        child: GoogleMap(
          markers: <Marker>{
           Marker(
             markerId: MarkerId("0"),
             position: LatLng(2.2190967, 102.4531847)
           ),
           
          },
          mapType: MapType.normal,
          initialCameraPosition: _jasin,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _shareCurrentLocation,
        label: Text("Share Current Location"),
        icon: Icon(Icons.location_on),
      ),
    );
  }
}