import 'package:meta/meta.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/resources/common_repo.dart';

import 'note.dart';



class GroupworkModel{
  final String id;
  final String creator;
  final String name;
  final String description;
  final String course;
  final String supervisor;
  final List<dynamic> invitations;
  final List<dynamic> members;
  final List<Note> notes;
  final String profilePicturerUrl;
  final String templateId;
  final double revision;


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
    this.profilePicturerUrl,
    @required this.templateId,
    this.revision,

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
      templateId: data['template_id'] != null ? data['template_id']['\$oid'] : null,
      revision: data['revision'] != null ? data['revision'].toDouble() : 0.00,
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
      "template_id":this.templateId,
      "revision":this.revision
    };
  }
}