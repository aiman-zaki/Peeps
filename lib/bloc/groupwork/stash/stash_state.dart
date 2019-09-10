import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StashState extends Equatable {
  StashState([List props = const <dynamic>[]]) : super(props);
}

class InitialStashState extends StashState {}


class LoadingStashState extends StashState{
  @override
  String toString() => "LoadingStashState";
}

class LoadedStashState extends StashState{
  @override
  String toString() => "LoadedStashState";
}