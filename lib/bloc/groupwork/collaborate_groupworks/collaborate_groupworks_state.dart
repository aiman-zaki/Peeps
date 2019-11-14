import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CollaborateGroupworksState extends Equatable {
  const CollaborateGroupworksState();
}

class InitialCollaborateGroupworksState extends CollaborateGroupworksState {
  @override
  List<Object> get props => [];
}


class LoadingCollaborateGroupworksState extends CollaborateGroupworksState{

  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingCollaborateGroupworkState";
}

class LoadedCollaborateGroupworksState extends CollaborateGroupworksState{
  final data;
  LoadedCollaborateGroupworksState({
    @required this.data,
  });
  @override
  List<Object> get props => [];


  @override
  String toString() => "LoadedCollaborateGroupworksState";
}