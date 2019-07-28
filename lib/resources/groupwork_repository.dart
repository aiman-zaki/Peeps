import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:peeps/models/groupwork.dart';
import 'common_repo.dart';

class GroupworkRepository{
  final String _baseUrl = domain+groupworkUrl;

  Future<Map<String,dynamic>> joinedGroup() async{
    var token = await storage.read(key:"access_token");
    var response = await http.get(_baseUrl+"joined_group",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

    if(response.statusCode == 200){
      Map<String,dynamic> data = json.decode(response.body);
      return data;
    }
    else{
      throw Exception(response.statusCode);
    }
  }

  createGroupwork(Map data) async{
    var token = await storage.read(key:"access_token");
    var response = await http.post(_baseUrl+"user",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token",
              "Content-Type":"application/json"},
    body: json.encode(data),
    );
    if(response.statusCode == 200){

    }
    else {
      throw response.body;
    }
  }

  //TODO: MORE RESEARCH GET/PUT
  Future <List<dynamic>> fetchGroupworkDetail(List<dynamic> data) async{
    var token = accessToken();
    Map body = {
      'active_group':data
    };
    var response = await http.put(_baseUrl+"detail",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token",
              "Content-Type":"application/json"},
    body: json.encode(body));
    if(response.statusCode == 200){
      List<dynamic> decoded = json.decode(response.body);
      print(decoded);
      return decoded;
    }  else {
      throw("Opps Something Wrong");
    }
    
  
  
  }

  
}