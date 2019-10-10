import 'package:meta/meta.dart';

class ReplyModel{
  final id;
  final reply;
  final createdDate;
  final by;

  ReplyModel({
    @required this.id,
    @required this.reply,
    @required this.createdDate,
    @required this.by,  
  });


  static ReplyModel fromJson(Map<String,dynamic> json){
    return ReplyModel(
      id: json['_id']['\$oid'],
      reply: json['reply'],
      createdDate: DateTime.parse(json['created_date']),
      by: json['by']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "reply":this.reply,
      "created_date":this.createdDate.toString(),
      "by":this.by,
    };
  }
}