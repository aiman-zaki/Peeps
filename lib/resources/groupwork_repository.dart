import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:peeps/models/groupwork.dart';
import 'dart:convert';
import 'common_repo.dart';
import 'package:async/async.dart';
import 'dart:convert';
class GroupworkRepository{
  final String _baseUrl = domain+groupworkUrl;

  const GroupworkRepository();

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
    var response = await http.post(_baseUrl+"groupwork",
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

  uploadProfileImage(File image,String groupId) async {
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    final Uri uri = Uri.parse(_baseUrl+"profile/image");
    var token = await accessToken();

    var request = new http.MultipartRequest("POST",
      uri);
    request.fields['group_id'] = groupId;

    var multipartFile = new http.MultipartFile('image', stream, length,filename: (image.path));
    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);
  }

  //TODO: MORE RESEARCH GET/PUT
  Future <List<GroupworkModel>> fetchActiveGroupsDetail(List<dynamic> data) async{
    var token = accessToken();
    Map body = {
      'active_group':data
    };
    var response = await http.put(_baseUrl+"groupwork/detail",
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