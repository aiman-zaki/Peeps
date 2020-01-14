import 'package:flutter/cupertino.dart';
import 'package:peeps/enum/role_enum.dart';
import 'package:peeps/resources/common_repo.dart';

class UserModel {
  final String id;
  final String fname;
  final String lname;
  final String email;
  final String contactNo;
  final String programmeCode;
  final List<dynamic> activeGroup;
  final String picture;
  final Role role;
  final DateTime createdDate;

  UserModel({
    @required this.id,
    @required this.fname,
    @required this.lname,
    @required this.email,
    @required this.contactNo,
    @required this.programmeCode,
    this.activeGroup,
    @required this.picture,
    @required this.role,
    @required this.createdDate,
  
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
      role: Role.student,
      createdDate: DateTime.now()
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
      role: Role.values.elementAt(json['role']),
      createdDate: DateTime.parse(json['created_date'])
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
      role: Role.values.elementAt(json['role']),
      createdDate: DateTime.parse(json['created_date'])
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
      "role":this.role.index,
      "created_date":this.createdDate.toString(),
    };
  }
}
