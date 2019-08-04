import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io/manager.dart';
import 'common_repo.dart';

class ChatResources {
  SocketIOManager _manager;
  SocketIO _socket;
  String _room;
  List _chats = [];
  BehaviorSubject _chatsController = BehaviorSubject();

  Sink get updateChatsSink => _chatsController.sink;
  Stream get chatsStream => _chatsController.stream;
  List get chats => _chats;

  Future connect({
   @required namespace,
   @required String room
  }) async {
    _manager = SocketIOManager();
    _room = room;
    _socket = await _manager.createInstance(SocketOptions(
      domain+namespace,
    ));
    _socket.onConnect((data){
      _socket.emit('join', [{'room':room}]);
      print("connected");
    });
    _socket.connect();

  }

  void sendMessage(String message){
    Map data = {
      "message":message,
      "room":_room,
    };
    _socket.emit('send_message', [data]);
  }

  //List get chats => _chats;

  receiveMessage() {
    _socket.on('receive_message', (data){
      _chats.add(data);
      updateChatsSink.add(data);
    });
    
  }

  disconnect() async {
    await _manager.clearInstance(_socket);
  }







}