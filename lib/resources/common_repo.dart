import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//const String domain = "http://www.tryreboot.my:8080/";
const String domain = "http://192.168.1.10:5000/";
const String authUrl = "api/auth/";
const String usersUrl = "api/users";
const String userUrl = "api/user";
const String groupworksUrl = "api/groupworks";
const String groupworkUrl = "api/groupworks/groupwork";
const String assignmentUrl = "api/assignments/";
const String inboxUrl = "api/inbox";
const String forumUrl = "api/forums";
const String questionsUrl = "api/questions";
const String supervisorUrl = "api/supervisor";


final storage = new FlutterSecureStorage();

Future<String> accessToken() async{
  var token = await storage.read(key: "access_token");
  return token;
}

fetchHeaders() async {
  var token = await storage.read(key: "access_token");

  return {HttpHeaders.authorizationHeader: "Bearer $token",
                "Content-Type":"application/json"
  };

}
