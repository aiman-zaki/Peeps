import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/semantics.dart';

abstract class AssignmentTaskRequestsState extends Equatable {
  const AssignmentTaskRequestsState();
}

class InitialAssignmentTaskRequestsState extends AssignmentTaskRequestsState {
  @override
  List<Object> get props => [];
}

class LoadingAssignmentTaskRequestsState extends AssignmentTaskRequestsState{
  @override
  List<Object> get props =>[];
  @override
  String toString() => "LoadingAssignmentTaskRequestsState";
}

class LoadedAssingmentTaskRequestsState extends AssignmentTaskRequestsState{
  final data;
  LoadedAssingmentTaskRequestsState({
    @required this.data
  });

  @override
  List<Object> get props => [];
  @override
  String toString() => "LoadedAssignmnetTaskRequestsState";
}