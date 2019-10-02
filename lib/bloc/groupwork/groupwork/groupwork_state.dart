import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/models/groupwork.dart';

@immutable
abstract class GroupworkState extends Equatable {
  const GroupworkState();
  @override
  List<Object> get props => [];
}

class InitialGroupworkState extends GroupworkState{
  @override
  String toString() => "InitialGroupWorkState";
}

class InsertingGroupworkState extends GroupworkState{
  @override
  String toString() => "InsertingGroupworkState";
}

class InsertedGroupworkState extends GroupworkState{
  @override
  String toString() => "InsertedGroupworkState";
}

class LoadingGroupworkState extends GroupworkState {
  @override
  String toString() => "LoadingGroupworkState";
}

class LoadedGroupworkState extends GroupworkState {

  final List<GroupworkModel> data;

  LoadedGroupworkState({
    @required this.data
  });

  @override
  String toString() => "LoadedGroupworkState";
}

class NoGroupworkState extends GroupworkState{
  @override
  String toString() => "NoGroupworkState";
}