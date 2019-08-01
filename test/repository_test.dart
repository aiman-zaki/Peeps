import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:peeps/resources/chat.dart';
import 'package:peeps/resources/users_repository.dart';




void main(){
  test('User Repository',() async {
    final UsersRepository usersRepository = UsersRepository();
  
  });

  test('Chat',() async{
     ChatResources chat = new ChatResources();
    chat.setup(namespace: 'group_chat');
    chat.connect('test');
    chat.sendMessage("testis");
  });
}