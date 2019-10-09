import 'dart:async';
import 'dart:convert';
import 'package:peeps/models/message.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io/manager.dart';
import 'common_repo.dart';

class BaseSocketIO {
  
  SocketIOManager _manager;
  SocketIO _socketIO;
  String namespace;
  String room;


  bool _isProbablyConnected = false;


  BaseSocketIO({
    @required this.namespace,
    @required this.room,
  });

  Future connect() async {
    _isProbablyConnected = true;
    _manager = SocketIOManager();
    _socketIO =  await _manager.createInstance(SocketOptions(
      domain+namespace,
      enableLogging: true,
    ));
    _socketIO.onConnect((data) async {
      String token = await accessToken();
      _socketIO.emit('join', [{'token':token,'room':room}]);
    });
    _socketIO.connect();
  }

  Future disconnect() async {
    _isProbablyConnected = false;
    await _manager.clearInstance(_socketIO);
  }
 

  SocketIO get socketIO => _socketIO;




}