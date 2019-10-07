import 'package:meta/meta.dart';

class RequestModel{

  String email;
  DateTime createdDate;
  bool answer;

  RequestModel({
    @required this.email,
    @required this.createdDate,
    @required this.answer,
  
  });

  static RequestModel fromJson(Map<String,dynamic> data){
    return RequestModel(
      email: data['email'],
      createdDate: DateTime.parse(data['created_date']),
      answer: data['answer'] != null ? data['answer'] : false,
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "email":this.email,
      "created_date":this.createdDate.toString(),
      "answer":this.answer,
    };
  }

}