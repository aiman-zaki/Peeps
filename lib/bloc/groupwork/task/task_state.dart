import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/bloc/bloc.dart';

@immutable
abstract class TaskState extends Equatable {
  TaskState([List props = const <dynamic>[]]) : super(props);
}

class InitialTaskState extends TaskState {}

class DisplayMessageSnackbar extends TaskState{
  final String message;
  final String color;

  DisplayMessageSnackbar({
    @required this.message,
    @required this.color
  });
  
  @override
  String toString() => "SucceedAddTaskState";
}

class LoadingTaskState extends TaskState{
  @override
  String toString() => "LoadingTaskState";
}

class LoadedTaskState extends TaskState{
  final data;
  LoadedTaskState({
    @required this.data,
  });
  
  @override
  String toString() => "LoadedTaskState";
}


class DeletingTaskState extends TaskState{
  final taskId;
  DeletingTaskState({
    @required this.taskId,
  });

  @override
  String toString() => "DeletingTaskState";
}
class RefreshedAssignmentState extends TaskState{
  final assignment;
  RefreshedAssignmentState({
    @required this.assignment,
  });

  @override
  String toString() => "RefreshedAssignmentState";
}