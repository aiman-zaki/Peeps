import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:peeps/resources/users_repository.dart';
import '../bloc.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final UsersRepository repository;
  final ProfileBloc profileBloc;
  InboxBloc({@required this.repository, @required this.profileBloc}):assert(repository != null);
  
  @override
  InboxState get initialState => InitialInboxState();

  @override
  Stream<InboxState> mapEventToState(
    InboxEvent event,
  ) async* {
    if(event is LoadInboxEvent){
      yield LoadingInboxState();
      List data = await repository.fetchGroupInvitationInbox();
      if(data.isEmpty){
        yield NoInvitationState();
      }
      else{
        yield LoadedInboxState(data: data);
      }
    }
    if(event is ReplyInvitationEvent){
      await repository.replyInvitationInbox(event.reply, event.groupId);
      //TODO: Temp
      profileBloc.dispatch(LoadProfileEvent());
    }
  }
}
