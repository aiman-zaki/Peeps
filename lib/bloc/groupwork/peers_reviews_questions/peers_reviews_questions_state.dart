import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class PeersReviewsQuestionsState extends Equatable {
  const PeersReviewsQuestionsState();
}

class InitialPeersReviewsQuestionsState extends PeersReviewsQuestionsState {
  @override
  List<Object> get props => [];
}

class LoadingPeersReviewsQuestionsState extends PeersReviewsQuestionsState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingPeersReviewsQuestionsState";
}

class LoadedPeersReviewsQuestionsState extends PeersReviewsQuestionsState{
  final data;
  
  LoadedPeersReviewsQuestionsState({
    @required this.data
  });
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadedPeersReviewsQuestionsState";
}
