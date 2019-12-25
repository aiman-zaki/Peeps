import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AssignmentTimelineState extends Equatable {
  const AssignmentTimelineState();
}

class InitialAssignmentTimelineState extends AssignmentTimelineState {
  @override
  List<Object> get props => [];
}

class LoadingAssignmentTimelineState extends AssignmentTimelineState{
  @override
  String toString() => "LoadingAssignmentTimelineState";
  @override
  List<Object> get props => [];
}

class LoadedAssignmentTimelineState extends AssignmentTimelineState{
  final data;
  LoadedAssignmentTimelineState({
    @required this.data
  });
  @override
  String toString() => "LoadedAssignmentTimelineState";

  @override
  List<Object> get props => [];
}