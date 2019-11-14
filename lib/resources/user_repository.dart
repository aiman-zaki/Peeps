import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peeps/models/assignment.dart';

import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/inbox.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/models/user_tasks.dart';
import 'package:peeps/resources/base_respository.dart';
import 'common_repo.dart';
import 'package:async/async.dart';

class UserRepository extends BaseRepository{

  const UserRepository(
  ):super(baseUrl:userUrl);


  readProfile() async {
    var data = await super.read(namespace: 'profile');
    return UserModel.fromJson(data);
  
  }

  updateProfile({@required data}) async{
    await super.update(data: {
      "fname":data["fname"],
      "lname":data["lname"],
      "contact_no":data["contactNo"],
      "programme_code":data["programmeCode"]
    },namespace: 'profile');
  }

  updatePicture({@required File image,@required String id}) async {
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    final Uri uri = Uri.parse(url('upload'));
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

  readActiveGroupworks()async {
    var data = await super.read(namespace: "groupworks");
    List<GroupworkModel> groupworks = [];
    for(Map<String,dynamic> group in data){
      groupworks.add(GroupworkModel.fromJson(group));
    }

    return groupworks;
  }

  readGroupInvitationInbox({namespace}) async {
    var data = await super.read(namespace: "inbox/group_invitation");
    List<GroupInvitationMailModel> invitations = [];
    for(Map<String,dynamic> invitation in data){
      invitations.add(GroupInvitationMailModel.fromJson(invitation));
    }

    return invitations;
  
  }

  updateGroupInvitationInbox({@required data}) async{
    await super.update(data: data,namespace: "inbox/reply_invitation");
  }


  updateRequestGroupwork({@required data}) async {
    await super.update(data: data,namespace: "groupworks");
  }

  updateRole({@required data}) async {
    await super.update(data: data,namespace: "role");
  }

  readUserOnlyTask() async {
    var data = await super.read(namespace: "tasks");
    List<UserTasksModel> tasks = [];
    for(Map<String,dynamic> task in data){
      tasks.add(UserTasksModel.fromJson(task));
    }
    return tasks;
  }

  readUserAssignment() async {
    var data = await super.read(namespace: "assignments");
   
    for(Map<String,dynamic> groupwork in data){
      groupwork['assignments'] = groupwork['assignments'].map((assignment){
        return AssignmentModel.fromJson(assignment);
      }).toList();
    }

     print(data);
    return data;
  }








}