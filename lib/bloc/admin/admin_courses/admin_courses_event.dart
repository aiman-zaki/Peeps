import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class AdminCoursesEvent extends Equatable {
  const AdminCoursesEvent();
}


class ReadCoursesEvent extends AdminCoursesEvent{
  @override
  String toString() => "ReadCoursesEvent";

  @override
  List<Object> get props => []; 
}

class CreateCourseEvent extends AdminCoursesEvent{
  final data;
  CreateCourseEvent({
    @required this.data
  });
  @override
  String toString() => "CreateCourseEvent";

  @override
  List<Object> get props => [];
}

class UpdateCourseEvent extends AdminCoursesEvent{
  final data;
  final namespace;
  UpdateCourseEvent({
    @required this.data,
    @required this.namespace
  });

  @override
  String toString() => "UpdateCourseEvent";

  @override
  List<Object> get props => [];
}