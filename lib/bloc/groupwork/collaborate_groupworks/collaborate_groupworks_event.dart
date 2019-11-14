import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CollaborateGroupworksEvent extends Equatable {
  const CollaborateGroupworksEvent();
}


class ReadCollaborateGroupworksEvent extends CollaborateGroupworksEvent{
  final data;
  ReadCollaborateGroupworksEvent({@required this.data});
  @override
  List<Object> get props => [];

  @override
  String toString() => "ReadCollaborateGroupworksEvent";
}