import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserTaskState extends Equatable {
  const UserTaskState();
}

class InitialUserTaskState extends UserTaskState {
  @override
  List<Object> get props => [];
}

class LoadingUserTaskState extends UserTaskState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingUserTaskState";
}

class LoadedUserTaskState extends UserTaskState{
  final data;

  LoadedUserTaskState({
    @required this.data,
  });
  
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadeduserTaskState";
}