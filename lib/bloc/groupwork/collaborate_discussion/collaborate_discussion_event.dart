import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CollaborateDiscussionEvent extends Equatable {
  const CollaborateDiscussionEvent();
}

class LoadDiscussionEvent extends CollaborateDiscussionEvent{
  @override
  String toString() => "LoadDiscussionsEvent";

  @override
  List<Object> get props => null;
}
class CreateNewReplyEvent extends CollaborateDiscussionEvent{

  final data;

  CreateNewReplyEvent({
    @required this.data
  });

  @override
  String toString() => "CreateNewReplyEvent";

  @override
  List<Object> get props => null;
}

class DeleteReplyEvent extends CollaborateDiscussionEvent{
  final data;

  DeleteReplyEvent({
    @required this.data
  });

  @override
  List<Object> get props => [data];
}