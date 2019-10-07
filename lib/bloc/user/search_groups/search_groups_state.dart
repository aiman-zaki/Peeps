import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SearchGroupsState extends Equatable {
  const SearchGroupsState();
}

class InitialSearchGroupsState extends SearchGroupsState {
  @override
  List<Object> get props => [];
}

class LoadingGroupsState extends SearchGroupsState{
  @override
  String toString() => "LoadingGroupsState";

  @override
  List<Object> get props => null;
}

class LoadedGroupsState extends SearchGroupsState{

  final data;

  const LoadedGroupsState({
    @required this.data
  });
  
  @override
  String toString() => "LoadedGroupState";

  @override
  List<Object> get props => null;
}

class RequestingGroupState extends SearchGroupsState{

  const RequestingGroupState();
  
  @override
  String toString() => "RequestingGroupState";

  @override
  List<Object> get props => null;
}

class RequestedGroupState extends SearchGroupsState{
  const RequestedGroupState();

  @override
  String toString() => "RequestedGroupState";

  @override
  List<Object> get props => null;
}