import 'package:meta/meta.dart';

class ReplyModel{
  final id;
  final reply;
  final createdDate;

  ReplyModel({
    @required this.id,
    @required this.reply,
    @required this.createdDate,
  });


  static ReplyModel fromJson(Map<String,dynamic> json){
    return ReplyModel(
      id: json['_id']['\$oid'],
      reply: json['reply'],
      createdDate: DateTime.parse(json['created_date']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "reply":this.reply,
      "created_date":this.reply,
    };
  }
}