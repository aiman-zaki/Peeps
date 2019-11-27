import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class GroupworkTemplateSupervisorState extends Equatable {
  const GroupworkTemplateSupervisorState();
}

class InitialGroupworkTemplateSupervisorState extends GroupworkTemplateSupervisorState {
  @override
  List<Object> get props => [];
}

class LoadingGroupworkTemplateSupervisorState extends GroupworkTemplateSupervisorState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingGroupworkTemplateSupervisorState";
}

class LoadedGroupworkTemplateSupervisorState  extends GroupworkTemplateSupervisorState {
  final data;
  LoadedGroupworkTemplateSupervisorState({
    @required this.data
  });
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadedGroupworkTemplateSupervisorState";
}