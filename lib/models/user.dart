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
  

  UserModel({
    @required this.id,
    @required this.fname,
    @required this.lname,
    @required this.email,
    @required this.contactNo,
    @required this.programmeCode,
    @required this.activeGroup,
    @required this.picture,
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
      picture: ""
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
    );
  }

  
}