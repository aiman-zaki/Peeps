import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/bloc/groupwork/collaborate_forum/collaborate_forum_bloc.dart';
abstract class CollaborateForumEvent extends Equatable {
  const CollaborateForumEvent();
}


class LoadForumEvent extends CollaborateForumEvent{

  @override
  String toString () => "LoadForumEvent";

  @override
  List<Object> get props => [];
}

class CreateNewDiscussionEvent extends CollaborateForumEvent{
  final data;
  CreateNewDiscussionEvent({
    @required this.data
  });
  
  @override
  String toString() => "AddNewDiscussionEvent";

  @override
  List<Object> get props => [];
}