import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:peeps/models/groupwork.dart';
import 'dart:convert';
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
  Future <List<GroupworkModel>> fetchActiveGroupsDetail(List<dynamic> data) async{
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
      List<GroupworkModel> activeGroups = [];
      for(Map<String,dynamic> temp in decoded){
        activeGroups.add(GroupworkModel.fromJson(temp));
      }
      return activeGroups;
    }  else {
      throw("Opps Something Wrong");
    }

  }
  
  Future <List<dynamic>> fetchGroupworkStash(String groupId) async {
    var token = accessToken();
    Map body = {
      'group_id':groupId,
    };
    var response = await http.put(_baseUrl+"stash",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token",
            "Content-Type":"application/json"},
    body: json.encode(body));
    if(response.statusCode == 200){
      List<dynamic> decoded = json.decode(response.body);
      return decoded;
    } else {
      throw("Opps Message");
    }
  }

  
}