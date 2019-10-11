import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:peeps/models/changed_status.dart';

import 'package:peeps/resources/task_repository.dart';
import '../bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;
  TaskBloc({
    @required this.repository
  });

  @override
  TaskState get initialState => InitialTaskState();

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if(event is LoadTaskEvent){
      yield LoadingTaskState();
      final data = await repository.readTasks();
      yield LoadedTaskState(data: data);
    }
    if(event is AddNewTaskEvent){
      try {
        await repository.createTask(data: event.task.toJson());
        yield DisplayMessageSnackbar(color: "green", message: "Succeed");
      }catch(e){
        yield DisplayMessageSnackbar(color: "red", message: e.toString());
      }
      yield InitialTaskState();
    }
    //Im too lazy to come out with new solution
    //From card_task delete button, deleting task button will be emit and listend on kanban then dispatch to delete task
    if(event is DeleteTaskButtonClickedEvent){
      yield DeletingTaskState(taskId: event.taskId);
    }
    if(event is DeleteTaskEvent){
      repository.deleteTask(id: event.taskId);
      yield InitialTaskState();
    }
    if(event is UpdateTaskStatus){
      List<dynamic> changedStatusTask = [];
      for(ChangedStatus task in event.tasks){
        changedStatusTask.add(task.toJson());
      }
      repository.updateTaskStatus(data: changedStatusTask);
      yield DisplayMessageSnackbar(color: "green",message: "Saved");
      try{
        
      }catch(e){

      }
      yield InitialTaskState();
    }
    
  }
}
