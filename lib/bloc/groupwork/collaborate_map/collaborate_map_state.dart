import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class CollaborateMapState extends Equatable {
  const CollaborateMapState();
}

class InitialCollaborateMapState extends CollaborateMapState {
  @override
  List<Object> get props => [];
}

class LoadingMapMarkerState extends CollaborateMapState{
  @override
  List<Object> get props => [];
}
class LoadedMapMarkerState extends CollaborateMapState{
  final data;
  @override
  LoadedMapMarkerState({
    @required this.data,
  });
  @override
  List<Object> get props => [];
}