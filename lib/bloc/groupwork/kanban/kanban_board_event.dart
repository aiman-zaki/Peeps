import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class KanbanBoardEvent extends Equatable {
  const KanbanBoardEvent();
  @override
  List<Object> get props => [];
}


class LoadKanbanBoardEvent extends KanbanBoardEvent{
  @override
  String toString() => "LoadKanbanBoardEvent";
}
