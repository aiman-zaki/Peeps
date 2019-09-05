import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/changed_status.dart';
import 'package:peeps/resources/assignment_repository.dart';
import './bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AssignmentRepository repository;
  TaskBloc({
    @required this.repository
  });

  @override
  TaskState get initialState => InitialTaskState();

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if(event is AddNewTaskEvent){
      try {
        await repository.createTask(todo: event.task.toJson(),assignmentId: event.assignmentId,groupId: event.groupId);
        yield DisplayMessageSnackbar(color: "green", message: "Succeed");
      }catch(e){
        yield DisplayMessageSnackbar(color: "red", message: e.toString());
      }
      yield InitialTaskState();
    }
    if(event is UpdateTaskStatus){
      List<dynamic> changedStatusTask = [];
      for(ChangedStatus task in event.tasks){
        changedStatusTask.add(task.toJson());
      }
      repository.updateTaskState(assignmentId: event.assignmentId,changedStatusTask: changedStatusTask);
      yield DisplayMessageSnackbar(color: "green",message: "Saved");
      try{
        
      }catch(e){

      }
      yield InitialTaskState();
    }

    if(event is RefreshAssignmentEvent){
      AssignmentModel assignment = await repository.fetchAssignment(groupId: event.groupId,assignmentId: event.assignmentId);
      yield RefreshedAssignmentState(assignment: assignment);
      yield InitialTaskState();
    }
  }
}
