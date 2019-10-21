import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/chat.dart';
import '../bloc.dart';

class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  final ChatResources chat;

  GroupChatBloc({@required this.chat});
  
  @override
  GroupChatState get initialState => InitialGroupChatState();



  @override
  Stream<GroupChatState> mapEventToState(
    GroupChatEvent event,
  ) async* {
    if(event is LoadGroupChatEvent){
      yield LoadingGroupChatState();
      await chat.connect();
      yield LoadedGroupChatState(chatResources: chat);

    }

  }

  @override
  void close(){
    super.close();
    chat.disconnect();
  }
}
