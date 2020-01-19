import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class AssignmentTimelineUserState extends Equatable {
  const AssignmentTimelineUserState();
}

class InitialAssignmentTimelineUserState extends AssignmentTimelineUserState {
  @override
  List<Object> get props => [];
}


class LoadingAssignmentTimelineUserState extends AssignmentTimelineUserState{
  @override
  List<Object> get props => [];
}

class LoadedAssignmentTimelineUserState extends AssignmentTimelineUserState{
  final score;
  final contributions;

  LoadedAssignmentTimelineUserState({
    @required this.contributions,
    @required this.score,
  });

  @override
  List<Object> get props => [];
}