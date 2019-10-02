import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GroupChatEvent extends Equatable {
  const GroupChatEvent();
  @override
  List<Object> get props => [];
}


class LoadGroupChatEvent extends GroupChatEvent{
  final String room;
  LoadGroupChatEvent({@required this.room});
  @override
  String toString() => "LoadGroupChatEvent";
}

class SendMessageGroupChatEvent extends GroupChatEvent{

  final String messsage;
  SendMessageGroupChatEvent({
    @required this.messsage
  });

  @override
  String toString() => "sendMessageGroupChatEvent";
}

