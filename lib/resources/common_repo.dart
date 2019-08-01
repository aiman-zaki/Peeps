import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String domain = "http://192.168.1.159:5000/";
const String authUrl = "api/auth/";
const String userUrl = "api/users/";
const String groupworkUrl = "api/groupworks/";
const String inboxUrl = "api/inbox";
final storage = new FlutterSecureStorage();

Future<String> accessToken() async{
  var token = await storage.read(key: "access_token");
  return token;
}