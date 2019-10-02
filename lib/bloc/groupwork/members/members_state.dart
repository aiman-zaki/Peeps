import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MembersState extends Equatable {
  const MembersState();
  @override
  List<Object> get props => [];
}

class InitialMembersState extends MembersState {}

class LoadingMembersState extends MembersState{

  @override
  String toString() => "LoadingMembersState";
}
class LoadedMembersState extends MembersState{
  final data;
  LoadedMembersState({
    @required this.data
  });
  @override
  String toString() => "LoadedMembersState";
}

class LoadedProfileMember extends MembersState{
  @override
  String toString() => "LoadedProfileMember";
}

class LoadingSearchedResult extends MembersState{
  @override
  String toString() => "LoadingSearchedResult";
}
class LoadedSearchedUserResult extends MembersState{
  final data;
  LoadedSearchedUserResult({
    @required this.data,
  });
  @override
  String toString() => "SearchedUserResult";
}
