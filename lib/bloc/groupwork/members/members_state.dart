import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MembersState extends Equatable {
  MembersState([List props = const <dynamic>[]]) : super(props);
}

class InitialMembersState extends MembersState {}

class LoadedMembers extends MembersState{
  @override
  String toString() => "LoadMembers";
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
