import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class CollaborateDiscussionState extends Equatable {
  const CollaborateDiscussionState();
}

class InitialCollaborateDiscussionState extends CollaborateDiscussionState {
  @override
  List<Object> get props => [];
}

class LoadingDiscussionState extends CollaborateDiscussionState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadInitialDiscussionState";
}

class LoadedDiscussionState extends CollaborateDiscussionState{
  final data;
  LoadedDiscussionState({
    @required this.data,
  });
  
  @override
  List<Object> get props => [];
  
  @override
  String toString () => "LoadedDiscussionState";
}