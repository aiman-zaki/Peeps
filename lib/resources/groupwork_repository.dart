import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:peeps/models/groupwork.dart';
import 'common_repo.dart';

class GroupWorkRepositry{
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

  createGroup(GroupworkModel model) async{
    var token = await storage.read(key:"access_token");
    var response = await http.post(_baseUrl+"groupwork",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
 
    );
  }

  
}