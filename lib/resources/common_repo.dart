import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//const String domain = "http://www.tryreboot.my:8080/";
const String domain = "http://192.168.43.112:5000/";
const String authUrl = "api/auth/";
const String userUrl = "api/users/";
const String groupworkUrl = "api/groupworks";
const String assignmentUrl = "api/assignments/";
const String inboxUrl = "api/inbox";
const String forumUrl = "api/forums";
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
