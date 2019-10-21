import 'package:meta/meta.dart';

class StashModel{
  

}

class ReferenceModel{
  String id;
  String title;
  String reference;
  String creator;
  DateTime createdDate;


  ReferenceModel({
    @required this.id,
    @required this.title,
    @required this.reference,
    @required this.creator,
    @required this.createdDate,
  });

  static ReferenceModel fromJson(Map<String,dynamic> json){
    return ReferenceModel(
      id: json['_id']['\$oid'],
      title: json['title'],
      reference: json['reference'],
      creator:json['creator'],
      createdDate: DateTime.parse(json['created_date']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "title":this.title,
      "reference":this.reference,
      "creator":this.creator,
      "created_date":this.createdDate.toString()
    };
  }

}