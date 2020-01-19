import 'package:equatable/equatable.dart';

abstract class AssignmentTimelineUserEvent extends Equatable {
  const AssignmentTimelineUserEvent();
}

class ReadAssignmentTimelineUserEvent extends AssignmentTimelineUserEvent{
  @override
  List<Object> get props => [];
}