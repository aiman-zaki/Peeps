import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class AssignmentTaskRequestsEvent extends Equatable {
  const AssignmentTaskRequestsEvent();
}


class ReadTaskRequestsEvent extends AssignmentTaskRequestsEvent{
  @override
  String toString() => "ReadTaskRequestsEvent";

  @override
  List<Object> get props => [];
}

class UpdateTaskRequestEvent extends AssignmentTaskRequestsEvent{
  final data;
  UpdateTaskRequestEvent({
    @required this.data
  });

  @override
  String toString() => "UpdateTaskRequestEvent";

  @override
  List<Object> get props => [data];
}

