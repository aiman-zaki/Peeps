import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/forum_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class CollaborateForumBloc extends Bloc<CollaborateForumEvent, CollaborateForumState> {

  final ForumRepository repository;

  CollaborateForumBloc({
    @required this.repository,
  });


  @override
  CollaborateForumState get initialState => InitialCollaborateForumState();

  @override
  Stream<CollaborateForumState> mapEventToState(
    CollaborateForumEvent event,
  ) async* {
    if(event is LoadForumEvent){
      yield LoadingForumState();
      var data = await repository.read();
      yield LoadedForumState(data: data);
    }
    if(event is CreateNewDiscussionEvent){

      await repository.create(data:event.data);
      this.add(LoadForumEvent());
    }
    if(event is DeleteDiscussionEvent){
      try{
        var message = await repository.deleteForum(data: event.data);
        yield MessageForumState(message: message['message']);
      } catch(e){
        yield MessageForumState(message: e);
      }
      this.add(LoadForumEvent());

    }
  }
}
