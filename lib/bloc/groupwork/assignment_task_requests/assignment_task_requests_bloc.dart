import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/task_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class AssignmentTaskRequestsBloc extends Bloc<AssignmentTaskRequestsEvent, AssignmentTaskRequestsState> {
  final TaskRepository repository;
  AssignmentTaskRequestsBloc({
    @required this.repository
  });
  @override
  AssignmentTaskRequestsState get initialState => InitialAssignmentTaskRequestsState();

  @override
  Stream<AssignmentTaskRequestsState> mapEventToState(
    AssignmentTaskRequestsEvent event,
  ) async* {
    if(event is ReadTaskRequestsEvent){
      yield LoadingAssignmentTaskRequestsState();
      var data = await repository.readRequests();
      yield LoadedAssingmentTaskRequestsState(data: data);
    }
    if(event is UpdateTaskRequestEvent){
      await repository.updateRequest(data: event.data.toJson());
      this.add(ReadTaskRequestsEvent());
    }
  }
}
