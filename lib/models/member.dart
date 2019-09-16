import 'package:meta/meta.dart';
class MemberModel {
  String fname;
  String lname;
  String email;
  String contactNo;
  String programmeCode;

  MemberModel({
    @required this.fname,
    @required this.lname,
    @required this.email,
    @required this.contactNo,
    @required this.programmeCode,
  });

  static MemberModel fromJson(Map<String,dynamic> data){
    return MemberModel(
      fname: data['fname'],
      lname: data['lname'],
      email: data['email'],
      contactNo: data['contactNo'],
      programmeCode: data['programmeCode']
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