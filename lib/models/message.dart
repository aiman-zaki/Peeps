import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChatModel{

  String senderEmail;
  String message;
  String room;
  DateTime date;

  ChatModel(
    {
      @required this.senderEmail,
      @required this.message,
      this.room,
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

  static ChatModel fromJson(Map<String,dynamic> json ){
    return ChatModel(
      senderEmail: json['senderEmail'],
      message: json['message'],
      room: json['room'] != null ? json['room'] : "",
      date: DateTime.parse(json['date']),
    );

  }




}