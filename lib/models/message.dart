import 'dart:convert';

import 'package:flutter/foundation.dart';

class MessageModel{

  String senderEmail;
  String message;
  String room;
  DateTime date;

  MessageModel(
    {
      @required this.senderEmail,
      @required this.message,
      @required this.room,
      @required this.date,
    }
  );

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = {
      "senderEmail":senderEmail,
      "message":message,
      "room":room,
      "date":date.toString(),

    };
    return data;

  }

  static MessageModel fromJson( Map<String,dynamic> json ){
    return MessageModel(
      senderEmail: json['senderEmail'],
      message: json['message'],
      room: json['room'],
      date: DateTime.parse(json['date']),
    );

  }




}