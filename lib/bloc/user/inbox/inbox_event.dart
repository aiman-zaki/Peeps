import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InboxEvent extends Equatable {
  InboxEvent([List props = const []]) : super(props);
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
  ReplyInvitationEvent({@required this.reply, @required this.groupId}):super([reply,groupId]);

  @override
  String toString() => "ReplyInvitationEvent";
}