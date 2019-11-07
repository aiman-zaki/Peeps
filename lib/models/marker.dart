import 'package:meta/meta.dart';

class MarkerModel{
  String id;
  String email;
  DateTime createdDate;
  double longitude;
  double latitude;

  MarkerModel({
    @required this.id,
    @required this.email,
    @required this.createdDate,
    @required this.latitude,
    @required this.longitude,
  });


  static MarkerModel fromJson(Map<String,dynamic> json){
    return MarkerModel(
      id: json['_id']['\$oid'],
      email: json['email'],
      createdDate: DateTime.parse(json['created_date']),
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "email":this.email,
      "created_date":this.createdDate.toString(),
      "latitude":this.latitude,
      "longitude":this.longitude,
    };
  }

  



}