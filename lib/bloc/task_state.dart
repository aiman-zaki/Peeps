import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
class RefreshedAssignmentState extends TaskState{
  final assignment;
  RefreshedAssignmentState({
    @required this.assignment,
  });

  @override
  String toString() => "RefreshedAssignmentState";
}