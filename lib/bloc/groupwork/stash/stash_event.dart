import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StashEvent extends Equatable {
  StashEvent([List props = const <dynamic>[]]) : super(props);
}


class LoadStashEvent extends StashEvent{
  final String groupId;
  LoadStashEvent({@required this.groupId}): super([groupId]);
  @override
  String toString() => "LoadStashEvent";
}