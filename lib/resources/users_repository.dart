import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'common_repo.dart';

class UsersRepository{
  final String _baseUrl = domain+userUrl;

  UsersRepository(

  );
  Future<Map<String,dynamic>> fetchProfile () async {
    var token = await storage.read(key:"access_token");
    var response = await http.get(
      _baseUrl+"profile",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if(response.statusCode == 200){
      Map<String,dynamic> data = json.decode(response.body);
      return data;
    }
    else{
      throw Exception("Someting Happen");
    }
  }

  Future<Map<String,dynamic>> fetchInbox (String data) async {
    var token = await accessToken();
    var response = await http.get(
      _baseUrl+"inbox/$data",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if(response.statusCode == 200){
      Map<String,dynamic> data = json.decode(response.body);
            return data;
    }
    else{
       throw Exception("Someting Happen"); 
    }
  }

  Future<String> replyInvitationInbox(String answer,String groupid) async{
    var token = await accessToken();
    Map body = {
      "answer":answer,
      "group_id":groupid,
    };
    var response = await http.post(
      _baseUrl+"inbox/replyinvitation",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token","Content-Type":"application/json"},
      body: json.encode(body)
    );
    if(response.statusCode == 200){
      return "Invitation $answer";
    }
    return "Something Wrong";

    
  } 


}