import 'dart:async';
import 'package:bloc/bloc.dart';
import '../bloc.dart';
import 'package:meta/meta.dart';
class KanbanBoardBloc extends Bloc<KanbanBoardEvent, KanbanBoardState> {
  @override
  KanbanBoardState get initialState => InitialKanbanBoardState();

  @override
  Stream<KanbanBoardState> mapEventToState(
    KanbanBoardEvent event,
  ) async* {
    if(event is LoadKanbanBoardEvent){
      yield LoadingKanbanBoardState();
      yield LoadedKanbanBoardState();
    }
  }
}
