import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GroupChatState extends Equatable {
  GroupChatState([List props = const []]) : super(props);
}

class InitialGroupChatState extends GroupChatState {}

class LoadingGroupChatState extends GroupChatState {
  @override 
  String toString() => "LoadingGroupChatState";
}

class LoadedGroupChatState extends GroupChatState{
  @override
  String toString() => "LoadedGroupChatState";
}