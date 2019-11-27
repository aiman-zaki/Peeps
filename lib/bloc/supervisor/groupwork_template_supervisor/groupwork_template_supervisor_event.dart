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