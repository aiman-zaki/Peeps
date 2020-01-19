import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class AdminCoursesState extends Equatable {
  const AdminCoursesState();
}

class InitialAdminCoursesState extends AdminCoursesState {
  @override
  List<Object> get props => [];
}


class LoadingAdminCoursesState extends AdminCoursesState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "WaitingEventCoursesState";
}

class LoadedAdminCoursesState extends AdminCoursesState{
  final data;

  LoadedAdminCoursesState({
    @required this.data
  });

  @override
  List<Object> get props => [];
  @override
  String toString() => "LoadedAdminCoursesState";
}

class MessageCoursesState extends AdminCoursesState{
  final message;
  MessageCoursesState({
    @required this.message
  });
  
  @override
  List<Object> get props => [];

  @override
  String toString() => "MessageCoursesState";
}