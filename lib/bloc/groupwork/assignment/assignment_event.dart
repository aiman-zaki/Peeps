import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class AssignmentEvent extends Equatable {
  AssignmentEvent();
}

class LoadAssignmentEvent extends AssignmentEvent{
  final String groupId;

  LoadAssignmentEvent({
    @required this.groupId,
    }
  );

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

class DeleteAssignmentEvent extends AssignmentEvent{
  final data;
  
  @override
  DeleteAssignmentEvent({
    @required this.data,
  });
  
  @override
  List<Object> get props => [];
}