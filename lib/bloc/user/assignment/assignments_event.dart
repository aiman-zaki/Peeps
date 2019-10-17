import 'package:equatable/equatable.dart';

abstract class AssignmentsEvent extends Equatable {
  const AssignmentsEvent();
}


class LoadUserAssignmentsEvent extends AssignmentsEvent{
  @override
  String toString() => "LoadUserAssignmentsEvent";

  @override
  List<Object> get props => [];
}

