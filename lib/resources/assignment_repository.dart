import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/changed_status.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/task.dart';
import 'dart:convert';
import 'common_repo.dart';

class AssignmentRepository{
  final String _baseUrl = domain+assignmentUrl;
  
  const AssignmentRepository();

  Future <List<AssignmentModel>> fetchAllAssignments({String groupId}) async {
    List<AssignmentModel> assigments = [];
    Map data = {
      "group_id":groupId,
    };
    var body = json.encode(data);
    var token = await storage.read(key:"access_token");
    var response = await http.put(_baseUrl,
      body: body,  
      headers: {HttpHeaders.authorizationHeader: "Bearer $token", "Content-Type":"application/json",});
      List <dynamic> responseData = json.decode(response.body);
    if(response.statusCode == 200){
      for(Map<String,dynamic> assignment in responseData){
        assigments.add(AssignmentModel.fromJson(assignment));
      }
        return assigments;
      }else{
        throw("error");
      }
  }

  Future <AssignmentModel> fetchAssignment({String groupId,String assignmentId}) async {
    Map data = {
      "group_id":groupId,
      "assignment_id":assignmentId,
    };
    var body = json.encode(data);
    var token = await storage.read(key: "access_token");
    var response = await http.put(_baseUrl+"assignment",
    body: body,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token", 
                "Content-Type":"application/json",});
      
      Map<String,dynamic> responseData = json.decode(response.body)[0];
      if(response.statusCode == 200){
        return AssignmentModel.fromJson(responseData); 
      } else {
        throw responseData['message'];
      }
  }

  createAssignment({Map<String,dynamic> assignment,String groupId}) async{
    Map data = {
      "group_id":groupId,
      "assignment":assignment,
    };

    var body = json.encode(data);
    var token = await storage.read(key: "access_token");
    var response = await http.post(_baseUrl+"assignment",
      body: body,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token","Content-Type":"application/json"});
      if(response.statusCode == 200){
        return "Success";
      } else {
        throw response.body;
      }

  }


  createTask({Map<String,dynamic> todo, String groupId, String assignmentId}) async{
    Map data = {
      "assignment_id":assignmentId,
      "todo":todo,
    };

    var body = json.encode(data);
    var token = await storage.read(key:"access_token");

    var response = await http.post(_baseUrl+"task/add",
      body: body,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token", "Content-Type":"application/json",});
      Map<String,dynamic> responseData = json.decode(response.body);
      if(response.statusCode == 200){
        return responseData['message']; 
      } else {
        throw responseData['message'];
      }
    
    }

    void updateTaskState({String assignmentId ,List changedStatusTask}) async{
      Map data = {
        "assignment_id":assignmentId,
        "tasks": changedStatusTask,
      };
      var body = json.encode(data);
      var token = await storage.read(key: "access_token");
      var response = await http.put(_baseUrl+"task/status",
        body: body,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token", "Content-Type":"application/json"}
      );
      if(response.statusCode == 200){

      } else {
        throw ("Something");
      }
    }

    void deleteTask({String assignmentId,String taskId}) async {      
      final url = '$assignmentId/$taskId/task';
      var token = await storage.read(key: "access_token");
      var response = await http.delete(_baseUrl+url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token", "Content-Type":"application/json"}
      );
      if(response.statusCode == 200){
        
      } else {
        throw (response.body);
      }
    }

}