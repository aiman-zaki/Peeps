import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/assignment_repository.dart';
import 'package:peeps/resources/questions_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class PeersReviewsQuestionsBloc extends Bloc<PeersReviewsQuestionsEvent, PeersReviewsQuestionsState> {
  final AssignmentRepository assignmentRepository;
  final QuestionsRepository repository;

  PeersReviewsQuestionsBloc({
    @required this.repository,
    @required this.assignmentRepository,
  });
  
  @override
  PeersReviewsQuestionsState get initialState => InitialPeersReviewsQuestionsState();

  @override
  Stream<PeersReviewsQuestionsState> mapEventToState(
    PeersReviewsQuestionsEvent event,
  ) async* {
    if(event is ReadPeersReviewsQuestions){
      yield LoadingPeersReviewsQuestionsState();
      var data = await repository.readQuestions();
      yield LoadedPeersReviewsQuestionsState(data: data);
    }
    if(event is ReadPeersReviewsScoredWithQuestion){
      yield LoadingPeersReviewsQuestionsState();
      var questions = await repository.readQuestions();
      var score = await assignmentRepository.readPeerReviewScore();
      yield LoadedPeersReviewsQuestionsState(data: {
        "questions":questions,
        "score":score,
      });
    }


    if(event is SubmitPeersReviewQustionsWithAnswers){

      await assignmentRepository.createPeerReview(data: event.data.toJson());
    }
  }
}
