import 'package:equatable/equatable.dart';

abstract class AssignmentTimelineEvent extends Equatable {
  const AssignmentTimelineEvent();
}


class ReadAssignmentTimelineEvent extends AssignmentTimelineEvent{
  @override
  String toString() => "ReadAssignmentTimelineEvent";
  @override
  List<Object> get props => [];
}



