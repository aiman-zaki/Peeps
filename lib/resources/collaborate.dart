import 'dart:async';

import 'package:peeps/models/message.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/socket_io.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

class LiveCollaborate extends BaseSocketIO {
  UserModel currentUser;
  List _users = [];
  BehaviorSubject usersController;
  Sink get usersSink => usersController.sink;
  Stream get usersStream => usersController.stream;
  List get users => _users;

  List<ChatModel> chats = [];
  List<BehaviorSubject> chatsController = [];
  Sink chatSink(int index) => chatsController[index].sink;
  Stream chatStream(int index) => chatsController[index].stream;

  BehaviorSubject dump = BehaviorSubject();
  

  @override
  LiveCollaborate({
    @required namespace,
    @required room,
  }) : super(namespace:namespace,room:room);

  @override
  Future connect() async {
    await super.connect();
    usersController = BehaviorSubject();
    this.subscribeUsers();
    this.subscribeChats();


   
  }

  @override
  Future disconnect() async{
    print("Disconnecting");
    this.removeUsers(currentUser);
    usersController.close();
    this.chatsController.map((controller){
      print("closing");
      controller.close();
    });
    dump.close();
    await super.disconnect();
  }
 

  void sendUsers(UserModel user){
    currentUser = user;
    socketIO.emit('send_user', [user.toJson(),room]);
  }

  void removeUsers(UserModel user){
    socketIO.emit('remove_user', [user.toJson(),room]);
  }

  void subscribeUsers(){
    socketIO.on('subscribe_user', (data){
      _users = data.map((user){
        return UserModel.fromJsonV2(user);
      }).toList();
      chatsController.add(new BehaviorSubject());
      usersSink.add(data);
      socketIO.emit('join_chat', ['${room}_chat.']);
      
    });
  }


  void sendChat(ChatModel chat,index){
    socketIO.emit('send_chat', [chat.toJson(),'${room}_$index']);
  }

  void subscribeChats(){
    socketIO.on('subscribe_chat',(data){
      print("subscrice_chat");
      
      chats.add(ChatModel.fromJson(data));

    
    });
  }






}