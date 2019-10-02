import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InboxState extends Equatable {
  const InboxState();
  @override
  List<Object> get props => [];
}

class InitialInboxState extends InboxState {}

class LoadingInboxState extends InboxState {
  @override
  String toString() => "LoadingInboxState";
}

class LoadedInboxState extends InboxState{
  final data;
  LoadedInboxState({@required this.data});

  @override
  String toString() => "LoadedInboxState";
}
class NoInvitationState extends InboxState{
  @override
  String toString() => "NoInvitationState";
}