import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/models/changed_status.dart';

@immutable
abstract class TaskEvent extends Equatable {
  TaskEvent([List props = const <dynamic>[]]) : super(props);
}

class AddNewTaskEvent extends TaskEvent{
  final groupId;
  final assignmentId;
  final task;
  AddNewTaskEvent({
    @required this.groupId,
    @required this.assignmentId,
    @required this.task
  });

  @override
  String toString() => "AddNewTaskEvent";
}

class UpdateTaskStatus extends TaskEvent{
  final assignmentId;
  final List<ChangedStatus> tasks;
  UpdateTaskStatus({
    @required this.tasks,
    @required this.assignmentId,
  });
  @override
  String toString() => "UpdateTaskStatus";
}

class RefreshAssignmentEvent extends TaskEvent{
  final groupId;
  final assignmentId;

  RefreshAssignmentEvent({
    @required this.groupId,
    @required this.assignmentId
  });
  
  @override
  String toString() => "RefreshAssignmentEvent";
}



