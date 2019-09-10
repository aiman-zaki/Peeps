import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class KanbanBoardEvent extends Equatable {
  KanbanBoardEvent([List props = const []]) : super(props);
}


class LoadKanbanBoardEvent extends KanbanBoardEvent{
  @override
  String toString() => "LoadKanbanBoardEvent";
}
