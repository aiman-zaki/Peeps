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
    String json =  '{"date":"2019-08-05 13:11:23.178026"}';
    print(json);
    Map<String,dynamic> jsonMap = jsonDecode(json);
    print(jsonMap);
  });
}