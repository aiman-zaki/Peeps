import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class UserTaskEvent extends Equatable {
  const UserTaskEvent();
}


class LoadUserTaskEvent extends UserTaskEvent{


  LoadUserTaskEvent();

  @override 
  String toString() => "LoadUserTaskEvent";

  @override
  List<Object> get props => [];
}