import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class PeersReviewsQuestionsEvent extends Equatable {
  const PeersReviewsQuestionsEvent();
}


class ReadPeersReviewsQuestions extends PeersReviewsQuestionsEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() => "ReadPeersReviewsQuestions";
}

class SubmitPeersReviewQustionsWithAnswers extends PeersReviewsQuestionsEvent{
  final data;
  SubmitPeersReviewQustionsWithAnswers({
    @required this.data,
  }
  );
  @override
  String toString() => "SubmitPeersReviewQustionsWithAnswers";

  @override
  List<Object> get props => [data];
}