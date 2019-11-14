import 'package:meta/meta.dart';
import 'package:peeps/screens/groupwork/review/rate_enum.dart';

class QuestionModel {
  
  final String id;
  final String question;
  Rate answer;

  QuestionModel({
    @required this.id,
    @required this.question,
    this.answer,
  });

  static QuestionModel fromJson(Map<String,dynamic> json){
    return QuestionModel(
      id: json['_id']['\$oid'],
      question: json['question'],
      answer: json['answer'] == null ? Rate.normal : Rate.values.elementAt(json['answer']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      '_id':this.id,
      'answer':this.answer.index,
    };
  }

  String toString() => "id:$id,question:$question,answer:${answer.index}";



}