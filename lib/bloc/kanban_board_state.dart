import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class KanbanBoardState extends Equatable {
  KanbanBoardState([List props = const []]) : super(props);
}

class InitialKanbanBoardState extends KanbanBoardState {}


class LoadingKanbanBoardState extends KanbanBoardState{
  @override
  String toString () => "LoadingKanbanBaordState";
}

class LoadedKanbanBoardState extends KanbanBoardState{
  @override
  String toString () => "LoadedKanbanBoard";
}

