import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/groupwork.dart';
import 'dart:convert';
import 'common_repo.dart';

class AssignmentRepository{
  final String _baseUrl = domain+assignmentUrl;

  Future <List<AssignmentModel>> fetchAssignment({String groupId}) async {
    print(groupId);
    List<AssignmentModel> assigments = [];
    Map data = {
      "group_id":groupId,
    };
    var body = json.encode(data);
    var token = await storage.read(key:"access_token");
    var response = await http.put(_baseUrl+"assignment",
      body: body,  
      headers: {HttpHeaders.authorizationHeader: "Bearer $token", "Content-Type":"application/json",});
      Map<String,dynamic> responseData = json.decode(response.body);
    if(response.statusCode == 200){
   
     
      for(Map<String,dynamic> assignment in responseData['assignments']){
        assigments.add(AssignmentModel.fromJson(assignment));
      }
      return assigments;
    } else if(response.statusCode != 200){
      throw(responseData['message']);
    }
    
    return assigments;
  }

}