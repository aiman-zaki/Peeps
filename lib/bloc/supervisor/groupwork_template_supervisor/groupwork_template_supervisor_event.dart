import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class GroupworkTemplateSupervisorEvent extends Equatable {
  const GroupworkTemplateSupervisorEvent();
}

class ReadGroupworkTemplateSupervisorEvent extends GroupworkTemplateSupervisorEvent{
  @override
  List<Object> get props => [];
  @override
  String toString() => "ReadGroupworkTemplateSupervisorEvent";
}
class CreateGroupworkTemplateSupervisorEvent extends GroupworkTemplateSupervisorEvent{
  final data;
  CreateGroupworkTemplateSupervisorEvent({
    @required this.data
  });
  @override
  List<Object> get props => [];

  @override
  String toString() => "CreateGroupworkTemplateSupervisorEvent";
}

class UpdateGroupworkTemplateSupervisorEvent extends GroupworkTemplateSupervisorEvent{
  final data;

  UpdateGroupworkTemplateSupervisorEvent({
    @required this.data
  });

  @override
  String toString() => "UpdateGroupworkTemplateSupervisorEvent";
  @override
  List<Object> get props => [];
}

class GroupworkTemplateSupervisorErrorEvent extends GroupworkTemplateSupervisorEvent{
  final error;

  GroupworkTemplateSupervisorErrorEvent({
    @required this.error
  });

  @override
  String toString() => "GroupworkTemplateSupervisorErrorEvent";

  @override
  List<Object> get props => [error];
}


