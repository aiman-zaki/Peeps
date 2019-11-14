import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/models/assignment.dart';

@immutable
abstract class AssignmentState extends Equatable {

  const AssignmentState();
  @override
  List<Object> get props => [];
}

class InitialAssignmentState extends AssignmentState {

}

class LoadingAssignmentState extends AssignmentState{
  @override
  String toString() => "LoadingAssignmentState";
}

class LoadedAssignmentState extends AssignmentState{
  final List<AssignmentModel> data;

  LoadedAssignmentState({
    @required this.data,
  });
  
  @override
  String toString() => "LoadedAssignmentState";
}

class UpdatingAssignmentStatusState extends AssignmentState{
  @override
  String toString() => "UpdatingAssignmentStatusState";

  @override
  List<Object> get props => [];
}

class UpdatedAssignmentStatusState extends AssignmentState{
  @override
  String toString() => "UpdatedAssignmentStatusState";

  @override
  List<Object> get props => [];
}