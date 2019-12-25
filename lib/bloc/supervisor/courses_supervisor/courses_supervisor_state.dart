import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class CoursesSupervisorState extends Equatable {
  const CoursesSupervisorState();
}

class InitialCoursesSupervisorState extends CoursesSupervisorState {
  @override
  List<Object> get props => [];
}

class LoadingCoursesSupervisorState extends CoursesSupervisorState{
  @override
  List<Object> get props=> [];
  @override
  String toString() => "LoadingCoursesSupervisorState";
}

class LoadedCoursesSupervisorState extends CoursesSupervisorState{
  final data;
  LoadedCoursesSupervisorState({
    @required this.data
  });

  @override
  List<Object> get props => [data];
}

class MessageCoursesSupervisorState extends CoursesSupervisorState{
  final message;
  MessageCoursesSupervisorState({
    @required this.message
  });

  @override
  List<Object> get props => [message];
}