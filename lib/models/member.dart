import 'package:meta/meta.dart';

import '../resources/common_repo.dart';
class MemberModel {
  String id;
  String fname;
  String lname;
  String email;
  String contactNo;
  String programmeCode;
  String profilePicture;

  MemberModel({
    @required this.id,
    @required this.fname,
    @required this.lname,
    @required this.email,
    @required this.contactNo,
    @required this.programmeCode,
    this.profilePicture,
  });

  static MemberModel fromJson(Map<String,dynamic> data){
    final String url = domain+'static/users/${data['_id']['\$oid']}/profile/image';

    return MemberModel(
      id: data['_id']['\$oid'],
      fname: data['fname'],
      lname: data['lname'],
      email: data['email'],
      contactNo: data['contactNo'],
      programmeCode: data['programmeCode'],
      profilePicture: url
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "fname":this.fname,
      "lname":this.lname,
      "email":this.email,
      "contactNo":this.contactNo,
      "programmeCode":this.programmeCode,
    };
  }
}