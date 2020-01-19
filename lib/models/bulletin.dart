import 'package:meta/meta.dart';

class BulletinModel{
  String id;
  String title;
  String body;
  DateTime createdDate;
  DateTime updatedDate;
  String email;

  BulletinModel({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.createdDate,
    @required this.updatedDate,
    @required this.email,
  });

  static BulletinModel fromJson(Map<String,dynamic> json){
    return BulletinModel(
      id: json['_id']['\$oid'],
      title: json['title'],
      body: json['body'],
      email: json['email'],
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "title":this.title,
      "body":this.body,
      "email":this.email,
      "created_date":this.createdDate.toString(),
      "updated_date":this.updatedDate.toString(),
    };
  }


}