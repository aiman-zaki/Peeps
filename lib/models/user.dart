import 'package:flutter/cupertino.dart';

class UserModel {
  String fname;
  String lname;
  String contactNo;
  String programmeCode;

  UserModel({
    @required this.fname,
    @required this.lname,
    @required this.contactNo,
    @required this.programmeCode,
  });

  static UserModel fromJson(Map<String,dynamic> json){
    return UserModel(
      fname: json['profile']['fname'],
      lname: json['profile']['lname'],
      contactNo: json['profile']['contactNo'],
      programmeCode: json['profile']['programmeCode']
    );
  }

  
}