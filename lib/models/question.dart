import 'package:meta/meta.dart';
import 'package:peeps/screens/groupwork/review/rate_enum.dart';

class QuestionModel {
  
  final String id;
  final String question;
  final List<AnswerModel> answers;
  int star = 0;

  QuestionModel({
    @required this.id,
    @required this.question,
    @required this.answers,
  });

  static QuestionModel fromJson(Map<String,dynamic> json){

    List<dynamic> temp = json['answers'];
    List<AnswerModel> answers = [];
    for(int i = 0 ; i<temp.length; i++){
      answers.add(AnswerModel.fromJson(temp[i]));
    }
    return QuestionModel(
      id: json['_id']['\$oid'],
      question: json['question'],
      answers: answers
    );
  }

  Map<String,dynamic> toJson(){
    return {
      '_id':this.id,
      'question':this.question,
      'answers':this.answers,
    };
  }
}

class AnswerModel{
  final String id;
  final String answer;

  AnswerModel({
    @required this.id,
    @required this.answer,
  });

  static AnswerModel fromJson(Map<String,dynamic> json){
    print(json);
    return AnswerModel(
      id: json['_id']['\$oid'],
      answer: json['answer'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "answer":this.answer,
    };
  }
}

