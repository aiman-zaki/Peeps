import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GroupworkEvent extends Equatable {
  GroupworkEvent([List props = const []]) : super(props);
}


class LoadGroupworkEvent extends GroupworkEvent{
  @override
  String toString() => "LoadGroupworkEvent";
}