import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'common_repo.dart';

class AuthRepository {
  final String baseUrl = domain+authUrl;

  Future<String> authenticate({
    @required String email,
    @required String password,
  }) async{
    Map data = {
      "email":email,
      "password":password,
    };
    var body = json.encode(data);
    var response = await http.post(baseUrl+"login",
      headers: {"Content-Type":"application/json"},
      body:body
    ).catchError((onError) => {

    });
    Map responsejson = json.decode(response.body);
    if(response.statusCode == 200){
      
      await storage.write(key:"access_token",value: responsejson['access_token']);
      await storage.write(key:"refresh_token",value: responsejson['refresh_token']);
      return "200";
    } 
    else if(response.statusCode != 200){
      throw (responsejson['message']);
    }
    return "400";
  }

  Future createUser({data}) async{
    var response = await http.post(baseUrl+"register",body:jsonEncode(data),headers: {"Content-Type":"application/json"});
    return response;
  }

  Future<http.Response> refreshToken() async{
    var token = await storage.read(key:"refresh_token");
    var response = await http.post(baseUrl+"refresh",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    Map responsejson = json.decode(response.body);
    await storage.write(key: "access_token",value: responsejson['access_token']);
    return response;
  }

  Future<void> deleteToken() async{
    await storage.deleteAll();
  }

  Future<bool> hasToken() async{
    var key = await storage.read(key: "access_token");
    if(key != null){
      await refreshToken();
      return true;
    }
    else 
      return false;
  }
}