import 'package:flutter/cupertino.dart';
import 'package:peeps/resources/common_repo.dart';

class UserModel {
  String id;
  String fname;
  String lname;
  String email;
  String contactNo;
  String programmeCode;
  List<dynamic> activeGroup;
  String picture;
  int role;

  UserModel({
    @required this.id,
    @required this.fname,
    @required this.lname,
    @required this.email,
    @required this.contactNo,
    @required this.programmeCode,
    this.activeGroup,
    @required this.picture,
    this.role,
  
  });

  static UserModel defaultConst(){
    return UserModel(
      id:"",
      email: "",
      fname: "",
      lname: "",
      contactNo: "",
      programmeCode: "",
      activeGroup: [],
      picture: "",
      role: 2,
    );
  }

  static UserModel fromJson(Map<String,dynamic> json){
    final String url = domain+'static/users/${json['_id']['\$oid']}/profile/image';
    return UserModel(
      id: json["_id"]["\$oid"],
      fname: json['profile']['fname'],
      lname: json['profile']['lname'],
      email: json['email'],
      contactNo: json['profile']['contact_no'],
      programmeCode: json['profile']['programme_code'],
      activeGroup: json['active_group'],
      picture: url,
      role: json['role']
    );
  }

  static UserModel fromJsonV2(Map<String,dynamic> json){
    final String url = domain+'static/users/${json['id']}/profile/image';
    return UserModel(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      contactNo: json['contact_no'],
      programmeCode: json['programme_code'], 
      picture: url,
    );
  
  }

  Map<String,dynamic> toJson(){
    return {
      "id": this.id,
      "fname": this.fname,
      "lname":this.lname,
      "email":this.email,
      "contact_no":this.contactNo,
      "programme_code":this.programmeCode,
    };
  }

  
}