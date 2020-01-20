import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class SupervisorMessagesEvent extends Equatable {
  const SupervisorMessagesEvent();
}


class ReadSupervisorMessagesEvent extends SupervisorMessagesEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() => "ReadSupervisorMessagesEvent";
}


class CreateSupervisorMessagesEvent extends SupervisorMessagesEvent{
  final data;
  CreateSupervisorMessagesEvent({
    @required this.data
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => "CreateSupervisorMessagesEvent";
}