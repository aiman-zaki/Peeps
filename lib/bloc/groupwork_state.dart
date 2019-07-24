import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GroupworkState extends Equatable {
  GroupworkState([List props = const []]) : super(props);
}

class InitialGroupworkState extends GroupworkState {}

class LoadingGroupworkState extends GroupworkState {
  @override
  String toString() => "LoadingGroupworkState";
}

class LoadedGroupwokState extends GroupworkState {
  @override
  String toString() => "LoadedGroupworkState";
}