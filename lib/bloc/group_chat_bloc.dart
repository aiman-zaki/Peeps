import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/chat.dart';
import './bloc.dart';

class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  @override
  GroupChatState get initialState => InitialGroupChatState();

  @override
  Stream<GroupChatState> mapEventToState(
    GroupChatEvent event,
  ) async* {
    if(event is LoadGroupChatEvent){
      yield LoadingGroupChatState();
      yield LoadedGroupChatState();
    }

  }
}
