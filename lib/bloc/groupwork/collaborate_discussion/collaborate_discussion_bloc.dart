import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/discussion_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class CollaborateDiscussionBloc extends Bloc<CollaborateDiscussionEvent, CollaborateDiscussionState> {

  final DiscussionRepository repository;

  CollaborateDiscussionBloc({
    @required this.repository
  });


  @override
  CollaborateDiscussionState get initialState => InitialCollaborateDiscussionState();

  @override
  Stream<CollaborateDiscussionState> mapEventToState(
    CollaborateDiscussionEvent event,
  ) async* {
    if(event is LoadDiscussionEvent){
      yield LoadingDiscussionState();
      var data = await repository.read();
      yield LoadedDiscussionState(data: data);
    }
    if(event is CreateNewReplyEvent){
      repository.create(data:event.data.toJson());
    }
    if(event is DeleteReplyEvent){
      repository.update(data:event.data.toJson());
    }
  }
}
