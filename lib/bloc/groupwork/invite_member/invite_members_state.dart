import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class InviteMembersState extends Equatable {
  InviteMembersState();
  @override
  List<Object> get props => [];
}

class InitialInviteMembersState extends InviteMembersState {
  @override
  List<Object> get props => [];
}

class LoadingUsersState extends InviteMembersState{
  @override
  String toString() => "LoadingUsersState";
}

class LoadedUsersState extends InviteMembersState{
  final data;

  LoadedUsersState({
    @required this.data
  });
  @override
  String toString() => "LoadedUsersState";
}


class InvitingMemberState extends InviteMembersState{
  @override
  String toString() => "InvitingMemberState";
}

class InvitedMemberState extends InviteMembersState{
  @override
  String toString() => "InvitedMemberState";
}
