import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AssignmentsState extends Equatable {
  const AssignmentsState();
}

class InitialAssignmentsState extends AssignmentsState {
  @override
  List<Object> get props => [];
}


class LoadingUserAssignmentsState extends AssignmentsState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingUserAssignmentsState";
}

class LoadedUserAssignmentsState extends AssignmentsState{
  final data;

  @override
  LoadedUserAssignmentsState({
    @required this.data
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadedUserAssignmentsState";
}