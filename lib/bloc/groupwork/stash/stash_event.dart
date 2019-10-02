import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StashEvent extends Equatable {
  const StashEvent();
  @override
  List<Object> get props => [];
}


class LoadStashEvent extends StashEvent{
  final String groupId;
  LoadStashEvent({@required this.groupId});
  @override
  String toString() => "LoadStashEvent";
}