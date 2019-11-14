import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/assignment_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class PeerReviewBloc extends Bloc<PeerReviewEvent, PeerReviewState> {
  final AssignmentRepository repository;

  PeerReviewBloc({
    @required this.repository
  });


  @override
  PeerReviewState get initialState => InitialPeerReviewState();

  @override
  Stream<PeerReviewState> mapEventToState(
    PeerReviewEvent event,
  ) async* {
    if(event is LoadPeerReviewEvent){
      yield LoadingPeerReviewState();
      var data = await repository.readPeerReview();
      yield LoadedPeerReviewState(data: data);
    }
  }
}
