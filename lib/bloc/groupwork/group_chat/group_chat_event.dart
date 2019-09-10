import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GroupChatEvent extends Equatable {
  GroupChatEvent([List props = const []]) : super(props);
}


class LoadGroupChatEvent extends GroupChatEvent{
  final String room;
  LoadGroupChatEvent({@required this.room}):super([room]);
  @override
  String toString() => "LoadGroupChatEvent";
}

class SendMessageGroupChatEvent extends GroupChatEvent{

  final String messsage;
  SendMessageGroupChatEvent({
    @required this.messsage
  }):super([messsage]);

  @override
  String toString() => "sendMessageGroupChatEvent";
}

