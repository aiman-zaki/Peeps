import 'package:meta/meta.dart';


class TimelineModel{
  String id;
  String by;
  String description;
  DateTime createdDate;
  int type;
  String room;
  
  TimelineModel({
    this.id,
    @required this.by,
    @required this.description,
    @required this.createdDate,
    @required this.type,
    this.room,
  });

  static TimelineModel fromJson(Map<String,dynamic> data){
    return TimelineModel(
      by:data['by'],
      description:data['description'],
      createdDate: DateTime.parse(data['created_date']),
      type:data['type'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "by":this.by,
      "description":this.description,
      "created_date":this.createdDate.toString(),
      "type":this.type,
      "room":this.room,
    };
  }

}


