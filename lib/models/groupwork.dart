import 'package:meta/meta.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/resources/common_repo.dart';

import 'note.dart';



class GroupworkModel{
  String id;
  String creator;
  String name;
  String description;
  String course;
  String supervisor;
  List<dynamic> invitations;
  List<dynamic> members;
  List<AssignmentModel> assignments;
  List<Note> notes;
  String profilePicturerUrl;


  GroupworkModel({
    this.id,
    @required this.creator,
    @required this.name,
    @required this.description,
    @required this.course,
    @required this.invitations,
    @required this.members,
    this.supervisor,
    this.notes,
    this.profilePicturerUrl

  });

  static GroupworkModel fromJson(Map<String,dynamic> data){
    final String url = domain+'static/groupworks/${data['_id']['\$oid']}/profile/image';

    List<Note> item = [];


    if(data['notes'] != null){
      for(Map<String,dynamic> note in data['notes']){
        item.add(Note.fromJson(note));
      }
    }
    
    return GroupworkModel(
      id: data['_id']['\$oid'],
      creator: data['creator'],
      name: data['name'],
      description: data['description'],
      course: data['course'],
      invitations: data['invitation_list'],
      members: data['members'],
      supervisor: data['supervisor'],
      notes: item,
      profilePicturerUrl: url,
    
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "creator":this.creator,
      "name":this.name,
      "description":this.description,
      "course":this.course,
      "members":this.members,
      "supervisor":this.supervisor,
      "invitation_list":this.invitations,
    };
  }
}