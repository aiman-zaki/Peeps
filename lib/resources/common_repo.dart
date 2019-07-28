import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final String domain = "http://192.168.1.159:5000/";
final String authUrl = "api/auth/";
final String userUrl = "api/users/";
final String groupworkUrl = "api/groupworks/";
final String inboxUrl = "api/inbox";
final storage = new FlutterSecureStorage();

Future<String> accessToken() async{
  var token = await storage.read(key: "access_token");
  return token;
}