import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/marker.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';

class CollaborateMapView extends StatefulWidget {
  CollaborateMapView({Key key}) : super(key: key);

  _CollaborateMapViewState createState() => _CollaborateMapViewState();
}

class _CollaborateMapViewState extends State<CollaborateMapView> {
  Completer<GoogleMapController> _controller = Completer();
  final _messageController = TextEditingController();

  static final CameraPosition _jasin = CameraPosition(
    target: LatLng(2.3084, 102.4304),
    zoom: 9.00,
  );

  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.of<CollaborateMapBloc>(context);
    ProfileLoaded _profileBloc = BlocProvider.of<ProfileBloc>(context).state;

    void _location() async {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _bloc.add(CreateMapMarkerEvent(
          data: MarkerModel(
              id: "",
              email: _profileBloc.data.email,
              message: _messageController.text,
              latitude: position.latitude,
              longitude: position.longitude,
              createdDate: DateTime.now(),
              url: _profileBloc.data.picture)));
      Navigator.of(context).pop();
    }

    Future<void> _shareCurrentLocation() async {
      showDialog(
          context: context,
          builder: (context) {
            return DialogWithAvatar(
              height: 200,
              avatarIcon: Icon(Icons.message),
              title: "Message to be Display on Marker",
              children: <Widget>[
                TextFormField(
                  controller: _messageController,
                ),
              ],
              bottomRight: RaisedButton(
                child: Text("Send"),
                onPressed: _location,
              ),
            );
          });
    }

    return BlocBuilder<CollaborateMapBloc, CollaborateMapState>(
      builder: (context, state) {
        if (state is LoadingMapMarkerState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedMapMarkerState) {
          Set<Marker> markers = Set();
          for (MarkerModel marker in state.data) {
            markers.add(Marker(
                position: LatLng(marker.latitude, marker.longitude),
                markerId: MarkerId(marker.id),
                icon: BitmapDescriptor.fromBytes(marker.icon),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context){
                      return SimpleDialog(
                        title: Text(marker.message),
                      );
                    }
                  );
                }));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Meet us"),
            ),
            body: Container(
              child: GoogleMap(
                markers: markers.isEmpty ? null : markers,
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
