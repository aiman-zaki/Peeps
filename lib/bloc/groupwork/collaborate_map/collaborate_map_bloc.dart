import 'dart:async';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class CollaborateMapBloc extends Bloc<CollaborateMapEvent, CollaborateMapState> {
  @override
  CollaborateMapState get initialState => InitialCollaborateMapState();

  @override
  Stream<CollaborateMapState> mapEventToState(
    CollaborateMapEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
