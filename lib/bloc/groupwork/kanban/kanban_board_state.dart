import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class KanbanBoardState extends Equatable {
  const KanbanBoardState();
  @override
  List<Object> get props => [];
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

