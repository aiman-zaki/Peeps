import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:peeps/resources/users_repository.dart';
import './bloc.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final UsersRepository repository;

  InboxBloc({@required this.repository}):assert(repository != null);
  
  @override
  InboxState get initialState => InitialInboxState();

  @override
  Stream<InboxState> mapEventToState(
    InboxEvent event,
  ) async* {
    if(event is LoadInboxEvent){
      yield LoadingInboxState();
      var data = await repository.fetchInbox(event.query);
      yield LoadedInboxState(data: data);
    }
    if(event is ReplyInvitationEvent){
      await repository.replyInvitationInbox(event.reply, event.groupId);
      this.dispatch(LoadInboxEvent(query: 'inbox.group_invitation'));

    }
  }
}
