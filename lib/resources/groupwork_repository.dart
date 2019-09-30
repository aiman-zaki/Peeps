import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/member.dart';
import 'package:peeps/models/user.dart';
import 'dart:convert';
import 'common_repo.dart';
import 'package:async/async.dart';
import 'dart:convert';
class GroupworkRepository{
  final String _baseUrl = domain+groupworkUrl;

  const GroupworkRepository();

 
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

  updateGroupwork(Map<String,dynamic> data) async {
    var headers = await fetchHeaders();
    var response = await http.put(_baseUrl+"groupwork",
      headers: headers,
      body: jsonEncode(data)
    );
    if(response.statusCode == 200){
  
    } else {
      throw("Opps Someting Error");
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

  Future <List<MemberModel>> fetchMembers(String groupId) async {
    var token = accessToken();
    var response = await http.get(_baseUrl+"$groupId/members",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    var responeData = jsonDecode(response.body);
    List<MemberModel> members = [];
    if(response.statusCode == 200){
      for(Map<String,dynamic> member in responeData){
        members.add(MemberModel.fromJson(member));
      }
    } 
    else{
      throw {"Message":"${responeData['message']}"};
    }
    return members;
  }

  

  Future updateRole(Map<String,dynamic> data) async{
    var token = await accessToken();
   
    var response = await http.put(
      _baseUrl+data['groupId']+"/roles",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token","Content-Type":"application/json"},
      body: jsonEncode(data)
    );

    if(response.statusCode == 200){
      return 200;
    }
  }

  Future inviteMember(Map<String,dynamic> data) async{
    var token = await accessToken();
    var response = await http.post(
      _baseUrl+data['groupId']+"/members",
      body: jsonEncode(data),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token","Content-Type":"application/json"}
    );

    if(response.statusCode == 200){
      return 200;
    }
  }

  Future deleteMember(Map<String,dynamic> data) async {
    var token = await accessToken();
    var response = await http.put(
      _baseUrl+data['groupId']+"/members",
      body: jsonEncode(data),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token","Content-Type":"application/json"}  
    );

    if(response.statusCode == 200){
      return 200;
    }
  }
}