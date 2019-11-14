import 'package:meta/meta.dart';
import 'package:peeps/models/question.dart';

class PeerReviewModel{
  final String reviewer;
  final String reviewee;
  final List answers;

  PeerReviewModel({
    @required this.reviewer,
    @required this.reviewee,
    @required this.answers,
  });


  static PeerReviewModel fromJson(Map<String,dynamic> json){
  
    return PeerReviewModel(
      reviewer: json['reviewer'],
      reviewee: json['reviewee'],
      answers: json['answers'].map((answer){
        return QuestionModel.fromJson(answer);
      }).toList(),
    );
  }

  static PeerReviewModel fromPeerReviewsJson(Map<String,dynamic> json,String reviewer){
    return PeerReviewModel(
      reviewer: reviewer,
      reviewee: json['reviewee'],
      answers: json['answers'].map((answer){
        return QuestionModel.fromJson(answer);
      }).toList(),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "reviewer":this.reviewer,
      "reviewee":this.reviewee,
      "answers":this.answers.map((answer){
        return answer.toJson();
      }).toList(),
    };
  }

  String toString() => "Reviewer : $reviewee , Reviewee : $reviewee , Anwesers : ${answers.toString()}";

}