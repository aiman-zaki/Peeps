import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/chat.dart';

@immutable
abstract class GroupChatState extends Equatable {
const GroupChatState();
   @override
  List<Object> get props => [];
}

class InitialGroupChatState extends GroupChatState {}

class LoadingGroupChatState extends GroupChatState {
  @override 
  String toString() => "LoadingGroupChatState";
}

class LoadedGroupChatState extends GroupChatState{
  final ChatResources chatResources;

  LoadedGroupChatState({@required this.chatResources});
  @override
  String toString() => "LoadedGroupChatState";
}