import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class CoursesSupervisorEvent extends Equatable {
  const CoursesSupervisorEvent();
}

class ReadCoursesSupervisorEvent extends CoursesSupervisorEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingCoursesSupervisorEvent";
}

class UpdateCoursesSupervisorEvent extends CoursesSupervisorEvent{
  final data;
  UpdateCoursesSupervisorEvent({
    @required this.data
  });
  
  @override
  List<Object> get props => [];

  @override
  String toString() => "UpdateCoursesSupervisorEvent";
}
