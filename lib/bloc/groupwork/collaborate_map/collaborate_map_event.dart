import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class CollaborateMapEvent extends Equatable {
  const CollaborateMapEvent();
}

class ReadMapMarkerEvent extends CollaborateMapEvent{
  @override
  List<Object> get props => [];
}

class CreateMapMarkerEvent extends CollaborateMapEvent{
  final data; 

  CreateMapMarkerEvent({
    @required this.data
  });

  @override
  String toString() => "CreateMarkerMapEvent";


  @override
  List<Object> get props => [];
}