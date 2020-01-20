import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class SupervisorMessagesState extends Equatable {
  const SupervisorMessagesState();
}

class InitialSupervisorMessagesState extends SupervisorMessagesState {
  @override
  List<Object> get props => [];
}


class LoadingSupervisorMessagesState extends SupervisorMessagesState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingSupervisorMessagesState";
}

class LoadedSupervisorMessagesState extends SupervisorMessagesState{
  final data;

  LoadedSupervisorMessagesState({
    @required this.data
  });

  @override
  List<Object> get props =>[];

  @override
  String toString() => "LoadedSupervisorMessagesState";
}

class MessageSupervisorMessagesState extends SupervisorMessagesState{
  final data;

  MessageSupervisorMessagesState({
    @required this.data
  });

  @override
  List<Object> get props =>[];

  @override
  String toString() => "MessageSupervisorMessagesState";
}