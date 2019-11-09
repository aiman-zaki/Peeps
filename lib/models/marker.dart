import 'dart:typed_data';

import 'package:meta/meta.dart';

class MarkerModel{
  String id;
  String email;
  String message;
  DateTime createdDate;
  double longitude;
  double latitude;
  String url;
  Uint8List icon;

  MarkerModel({
    @required this.id,
    @required this.email,
    @required this.message,
    @required this.createdDate,
    @required this.latitude,
    @required this.longitude,
    this.url,
    this.icon
  });


  static MarkerModel fromJson(Map<String,dynamic> json){
    return MarkerModel(
      id: json['_id']['\$oid'],
      email: json['email'],
      message: json['message'],
      createdDate: DateTime.parse(json['created_date']),
      longitude: json['longitude'],
      latitude: json['latitude'],
      icon: json['icon']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "email":this.email,
      "message":this.message,
      "created_date":this.createdDate.toString(),
      "latitude":this.latitude,
      "longitude":this.longitude,
      "url":this.url,
    };
  }

  



}