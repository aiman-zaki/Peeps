import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AssignmentEvent extends Equatable {
  AssignmentEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadAssignmentEvent extends AssignmentEvent{
  final String groupId;

  LoadAssignmentEvent({
    @required this.groupId,
    }
  );

  @override
  String toString() => "LoadAssignmentEvent";
}

class AddAssignmentEvent extends AssignmentEvent{
  @override
  String toString() => "AddAssignmentEvent";
}