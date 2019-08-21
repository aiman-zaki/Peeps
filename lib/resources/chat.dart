import 'dart:async';
import 'dart:convert';
import 'package:peeps/models/message.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io/manager.dart';
import 'common_repo.dart';

class ChatResources {
  SocketIOManager _manager;
  SocketIO _socket;
  String _room;
  List<ChatModel> _chats = [];
  BehaviorSubject _chatsController;
  bool isProbablyConnected = false;
  Sink get updateChatsSink => _chatsController.sink;
  Stream get chatsStream => _chatsController.stream;
  List<ChatModel> get chats => _chats;

  Future connect({
   @required namespace,
   @required String room
  }) async {
    String token = await accessToken();
    isProbablyConnected = true;
    _chatsController = BehaviorSubject();
    _manager = SocketIOManager();
    _room = room;
    _socket = await _manager.createInstance(SocketOptions(
      domain+namespace,
      enableLogging: true
    ));
    _socket.onConnect((data){
      _socket.emit('join', [{'token':token,'room':room}]);
      print("connected");
    });
    _socket.connect();
  }

  void sendMessage(ChatModel message){
    _socket.emit('send_message', [message.toJson()]);
  }

  //List get chats => _chats;

  receiveMessage() {
    _socket.on('receive_message',(data){
      ChatModel message = ChatModel.fromJson(data);
      _chats.add(message);
      updateChatsSink.add(data);
    });
    
  }

  disconnect() async {
    //updateChatsSink.close();
    isProbablyConnected = false;
    _chatsController.close();
    await _manager.clearInstance(_socket);
  }







}