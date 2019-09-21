import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:peeps/models/inbox.dart';
import 'package:peeps/models/user.dart';
import 'common_repo.dart';
import 'package:async/async.dart';
class UsersRepository{
  final String _baseUrl = domain+userUrl;
  
  const UsersRepository();

  createUser(String email,String password) async {
    var data = {
      "email":email,
      "password":password
    };
    var body = jsonEncode(data);

    var response = await http.post(
      _baseUrl+"user",
      body: body,
      headers: {"Content-Type": "application/json"}
    );
    Map responseData = jsonDecode(response.body);
    if(response.statusCode != 200){
      throw (responseData);
    }
  }

  updateProfile({@required Map<String,dynamic> data}) async{
    print(data);
    var body = {
      "fname":data["fname"],
      "lname":data["lname"],
      "contact_no":data["contactNo"],
      "programme_code":data["programmeCode"],
    };
    var token = await accessToken();
    var response = await http.put(
      _baseUrl+"user/profile",
      body: jsonEncode(body),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token",
                "Content-Type":"application/json"}
    );
    Map responseData = jsonDecode(response.body);
    if(response.statusCode != 200){
      throw (responseData);
    }
  }

  updateProfilePicture(File image,String id) async {
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    final Uri uri = Uri.parse(_baseUrl+"user/upload");
    var token = await accessToken();
    var length = await image.length();
    var request = new http.MultipartRequest("POST",
      uri);

    var multipartFile = new http.MultipartFile('image', stream, length,filename: (image.path));
    request.files.add(multipartFile);
    request.fields['user_id'] = id;
    request.headers.addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
    
    var response = await request.send();
    if(response.statusCode != 200){
      throw("Picture Failed to Upload");
    }
  }


  Future<UserModel> fetchProfile() async {
    var token = await storage.read(key:"access_token");
    var response = await http.get(
      _baseUrl+"user/profile",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if(response.statusCode == 200){
      Map<String,dynamic> data = json.decode(response.body);
      if(data != null)
         return UserModel.fromJson(data);
      else
        return null;
    }
    else{
      throw Exception("Someting Happen");
    }
  }

  Future<List<GroupInvitationMailModel>> fetchGroupInvitationInbox() async {
    var token = await accessToken();
    var response = await http.get(
      _baseUrl+"inbox/groupinvitation",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if(response.statusCode == 200){
      //TODO : Eliminate unnecessary hmm code
      List temp = jsonDecode(response.body);
      List<GroupInvitationMailModel> groupInvitation = [];
      for(Map<String,dynamic> group in temp){
          groupInvitation.add(GroupInvitationMailModel.fromJson(group));
      }      
      return groupInvitation;
    }
    else{
       throw Exception("Someting Happen"); 
    }
  }

  Future<String> replyInvitationInbox(bool answer,String groupid) async{
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