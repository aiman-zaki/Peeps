import 'package:meta/meta.dart';
import 'package:peeps/models/reply.dart';


class DiscussionModel{
  
  final String id;
  final String title;
  final String description;
  final List replies;

  DiscussionModel({
    @required this.id,
    @required this.title,
    @required this.description,
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
      replies: _replies,
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "title":this.title,
      "description":this.description,
      "replies":[],
    };
  }
}