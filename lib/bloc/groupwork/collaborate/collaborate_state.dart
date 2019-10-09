import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class CollaborateState extends Equatable {
  const CollaborateState();
}

class InitialCollaborateState extends CollaborateState {
  @override
  List<Object> get props => [];
}

class InitializingCollaborateState extends CollaborateState{
  @override
  String toString () => "InitializingCollaborateState";

  @override
  List<Object> get props => [];
}

class InitializedCollaborateState extends CollaborateState{

  final resource;

  InitializedCollaborateState({
    @required this.resource
  });

  @override
  String toString () => "InitializedCollaborateState";

  @override
  List<Object> get props => [];
}