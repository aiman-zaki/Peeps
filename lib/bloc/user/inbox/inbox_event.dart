import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InboxEvent extends Equatable {
  const InboxEvent();
  @override
  List<Object> get props => [];
}


class LoadInboxEvent extends InboxEvent{
  @override
  String toString() => "LoadInboxEvent";
}

class LoadInvitationListEvent extends InboxEvent{
  @override
  String toString() => "LoadInvitationListEvent";
}

class ReplyInvitationEvent extends InboxEvent{
  final reply;
  final groupId;
  ReplyInvitationEvent({@required this.reply, @required this.groupId});

  @override
  String toString() => "ReplyInvitationEvent";
}