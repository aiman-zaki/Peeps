import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class AssignmentEvent extends Equatable {
  AssignmentEvent();
}

class LoadAssignmentEvent extends AssignmentEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadAssignmentEvent";
}

class AddAssignmentEvent extends AssignmentEvent{
  final assignment;
  AddAssignmentEvent({
    @required this.assignment,
  });

  @override
  List<Object> get props => [];
  @override
  String toString() => "AddAssignmentEvent";
}

class UpdateAssignmentEvent extends AssignmentEvent{
  final data;
  UpdateAssignmentEvent({
    @required this.data
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => "UpdateAssignmentEvent";
}

class TaskRefreshButtonClicked extends AssignmentEvent{
  final latestAssignment;
  final assignments;

  TaskRefreshButtonClicked({
    @required this.latestAssignment,
    @required this.assignments,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => "TaskRefreshButtonClicked";
}

class UpdateAssignmentStatusEvent extends AssignmentEvent{
  final data;
  final user;
  UpdateAssignmentStatusEvent({
    @required this.data,
    @required this.user,
  });
  @override
  List<Object> get props => [];
  @override
  String toString() => "UpdateAssignmentStatusEvent";
}

class DeleteAssignmentEvent extends AssignmentEvent{
  final data;
  final user;
  
  @override
  DeleteAssignmentEvent({
    @required this.data,
    @required this.user,
  });
  
  @override
  List<Object> get props => [];
}