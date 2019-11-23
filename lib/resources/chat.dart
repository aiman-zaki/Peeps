import 'dart:async';
import 'package:peeps/models/message.dart';
import 'package:peeps/resources/socket_io.dart';
import 'package:rxdart/rxdart.dart';


class ChatResources extends BaseSocketIO {
  @override
  ChatResources({
    namespace,
    room,
  }) : super(namespace: namespace, room: room);

  List<ChatModel> chats = [];
  BehaviorSubject chatsController;

  @override
  Future connect() async {
    chatsController = BehaviorSubject();
    await super.connect();
    receiveMessage();
  }

  @override
  disconnect() async {
    super.disconnect();
    chatsController.close();
  }

  Sink get updateChatsSink => chatsController.sink;

  Stream get chatsStream => chatsController.stream;

  void sendMessage(ChatModel message) {
    super.socketIO.emit('send_message', [message.toJson()]);
  }

  void receiveMessage() {
    super.socketIO.on('receive_message', (data) {
      chats.add(ChatModel.fromJson(data));
      updateChatsSink.add(data);
    });
  }
}
