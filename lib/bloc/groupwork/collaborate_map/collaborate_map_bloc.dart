import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:peeps/models/marker.dart';
import 'package:peeps/resources/marker_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class CollaborateMapBloc extends Bloc<CollaborateMapEvent, CollaborateMapState> {
  final MarkerRepository repository;
  CollaborateMapBloc({
    @required this.repository
  });

  @override
  CollaborateMapState get initialState => InitialCollaborateMapState();

  @override
  Stream<CollaborateMapState> mapEventToState(
    CollaborateMapEvent event,
  ) async* {
    if(event is ReadMapMarkerEvent){
      yield LoadingMapMarkerState();
      var data = await repository.readMarkers();
   
      yield LoadedMapMarkerState(data: data);
    }
    if(event is CreateMapMarkerEvent){
      await repository.createMarker(data: event.data);
      this.add(ReadMapMarkerEvent());
    }
  }
}
