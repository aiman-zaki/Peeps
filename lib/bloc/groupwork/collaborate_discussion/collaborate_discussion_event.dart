import 'package:equatable/equatable.dart';

abstract class CollaborateDiscussionEvent extends Equatable {
  const CollaborateDiscussionEvent();
}

class LoadDiscussionEvent extends CollaborateDiscussionEvent{
  @override
  String toString() => "LoadDiscussionsEvent";

  @override
  List<Object> get props => null;
}