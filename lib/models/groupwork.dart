import 'package:meta/meta.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/resources/common_repo.dart';

class Note{
  String note;
  bool pinned;

  Note({
    @required this.note,
    @required this.pinned
  });

  static Note fromJson (Map<String,dynamic> data){
    return Note(
      note: data['note'],
      pinned: data['pinned']
    );
  }

}

class GroupworkModel{
  String id;
  String creator;
  String name;
  String description;
  String course;
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
    @required this.members,
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
      members: data['members'],
      notes: item,
      profilePicturerUrl: url,
    
    );
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data;
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['course'] = this.course;
    data['members'] = this.members;
    return data;
  }
}