import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class GroupworksSuperviseState extends Equatable {
  const GroupworksSuperviseState();
}

class InitialGroupworksSuperviseState extends GroupworksSuperviseState {
  @override
  List<Object> get props => [];
}


class LoadingGroupworksSuperviseState extends GroupworksSuperviseState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingGroupworksSuperviseState";
}

class LoadedGroupworksSuperviseState extends GroupworksSuperviseState{
  final data;
  LoadedGroupworksSuperviseState({
    @required this.data,
  });
  @override
  List<Object> get props => [];
  @override
  String toString() => "LoadedGroupworksSuperviseState";
}