import 'package:meta/meta.dart';

class NotificationModel{
  final String id;
  final String title;
  final String body;
  final bool notified;

  NotificationModel({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.notified,
  });

  static NotificationModel fromJson(Map<String,dynamic> json){
    return NotificationModel(
      id: json['_id']['\$oid'],
      title: json['title'],
      body: json['body'],
      notified: json['notified']
      
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "title":this.title,
      "body":this.body,
      "notified":this.notified
    };
  }


}