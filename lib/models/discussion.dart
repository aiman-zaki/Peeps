import 'package:meta/meta.dart';
import 'package:peeps/models/reply.dart';


class DiscussionModel{
  
  final String id;
  final String title;
  final String description;
  final String by;
  final DateTime createdDate;
  final List replies;

  DiscussionModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.by,
    @required this.createdDate,
    @required this.replies
  });

  static DiscussionModel fromJson(Map<String,dynamic> json){
    List _replies = json['replies'].map((reply){
      return ReplyModel.fromJson(reply);
    }).toList();
    
    return DiscussionModel(
      id: json['_id']['\$oid'],
      title: json['title'],
      description: json['description'],
      by: json['by'],
      replies: _replies, 
      createdDate: DateTime.parse(json['created_date']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "title":this.title,
      "description":this.description,
      "by":this.by,
      "created_date":this.createdDate.toString(),
      "replies":[],
    };
  }
}