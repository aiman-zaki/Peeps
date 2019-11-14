

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:peeps/models/note.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:http/http.dart' as http;


class NoteRepository extends BaseRepository{
  
  const NoteRepository({
    @required data
  }):super(baseUrl:groupworksUrl,data:data);

  readNotes() async {
    var data = super.read(namespace: 'notes');
    return data.map((note){
      return Note.fromJson(note);
    }).toList().cast<Note>();
  }

  final _baseUrl = domain+groupworksUrl;

  Future fetchNotes(Map<String,dynamic> data) async{
   
    var token = accessToken();

    var response = await http.get(
      "$_baseUrl/${data['groupId']}/notes",
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"}
    );

    var jsonData = jsonDecode(response.body);
    print(jsonData);
    List<Note> notes = [];
    if(response.statusCode == 200 && jsonData != null){
     
      for(Map<String,dynamic> note in jsonData['notes']){
        notes.add(Note.fromJson(note));
      }
      return notes;
    }
  }
}