import 'package:flutter/widgets.dart';
import 'package:peeps/models/groupwork.dart';

class GroupInvitationMailModel{

  String inviterEmail;
  String groupInviteId;
  String answer;
  GroupworkModel group;
  DateTime sentDate;


  GroupInvitationMailModel(
    {
      @required this.inviterEmail,
      @required this.groupInviteId,
      @required this.answer,
      @required this.group,
      @required this.sentDate,
    }
  );


  static GroupInvitationMailModel fromJson(Map<String,dynamic> json){
  
    return GroupInvitationMailModel(
      inviterEmail: json['invitation']['inviter'],
      groupInviteId: json['invitation']['group_id']['\$oid'],
      answer: json['invitation']['answer'].toString(),
      group: GroupworkModel.fromJson(json['group']),
      sentDate: json['invitation']['sentDate'],

    );
  }

  Map<String,dynamic> toJson(){
    return {
      "inviter":this.inviterEmail,
      "group_id":this.groupInviteId,
      "answer":this.answer,
      "sent_date":DateTime.now(),
    };
  }

}