import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/marker.dart';

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

  @override
  Widget build(BuildContext context) {

    var _bloc = BlocProvider.of<CollaborateMapBloc>(context);

    Future<void> _shareCurrentLocation() async {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _bloc.add(CreateMapMarkerEvent(data: MarkerModel(
        id: "",
        email: "",
        latitude: position.latitude,
        longitude: position.longitude,
        createdDate: DateTime.now()
      )));
    }

    return BlocBuilder<CollaborateMapBloc, CollaborateMapState>(
      builder: (context, state) {
        if (state is LoadingMapMarkerState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedMapMarkerState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Meet us"),
            ),
            body: Container(
              child: GoogleMap(
                markers: state.data.isEmpty ? null : state.data,
                mapType: MapType.normal,
                initialCameraPosition: _jasin,
                onMapCreated: (GoogleMapController controller) {
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
      },
    );
  }
}
