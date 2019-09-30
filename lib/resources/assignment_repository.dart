import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/changed_status.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/task.dart';
import 'dart:convert';
import 'common_repo.dart';

class AssignmentRepository{
  final String _baseUrl = domain+groupworkUrl;
  
  const AssignmentRepository();

  Future <List<AssignmentModel>> fetchAllAssignments({String groupId}) async {
    List<AssignmentModel> assigments = [];

    var token = await storage.read(key:"access_token");
    var response = await http.get(_baseUrl+groupId+"/assignments",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token", "Content-Type":"application/json",});
    var responseData = json.decode(response.body);
    print(responseData);
    if(response.statusCode == 200 && responseData.containsKey("assignments")){
      for(Map<String,dynamic> assignment in responseData['assignments']){
        assigments.add(AssignmentModel.fromJson(assignment));
      }
      
        return assigments;
      }else{
        return [];
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
    var response = await http.post(_baseUrl+"groupwork/assignment",
      body: body,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token","Content-Type":"application/json"});
      if(response.statusCode == 200){
        return "Success";
      } else {
        throw response.body;
      }

  }

  fetchTasks({@required assignmentId}) async {
    List<TaskModel> tasks = [];
    
    var token = await storage.read(key: "access_token");
    var response =  await http.get(_baseUrl+"groupwork/$assignmentId/tasks",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token","Content-Type":"application/json"});
      Map<String,dynamic> responseData = json.decode(response.body);
      if(response.statusCode == 200 && responseData != null){
        for(Map<String,dynamic> task in responseData['tasks']){
          tasks.add(TaskModel.fromJson(task));
        }
      }

      return tasks;

  }


  createTask({Map<String,dynamic> todo, String groupId, String assignmentId}) async{
    Map data = {
      "todo":todo,
    };

    var body = json.encode(data);
    var token = await storage.read(key:"access_token");

    var response = await http.post(_baseUrl+"groupwork/$assignmentId/task",
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
        "tasks": changedStatusTask,
      };
      var body = json.encode(data);
      var token = await storage.read(key: "access_token");
      var response = await http.put(_baseUrl+"groupwork/$assignmentId/task/status",
        body: body,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token", "Content-Type":"application/json"}
      );
      if(response.statusCode == 200){

      } else {
        throw ("Something");
      }
    }

    void deleteTask({String assignmentId,String taskId}) async {      
      var token = await storage.read(key: "access_token");
      var response = await http.delete(_baseUrl+"groupwork/$assignmentId/$taskId/task",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token", "Content-Type":"application/json"}
      );
      if(response.statusCode == 200){
        
      } else {
        throw (response.body);
      }
    }

}