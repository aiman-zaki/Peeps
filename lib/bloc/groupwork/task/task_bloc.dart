import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:peeps/enum/contribution_enum.dart';

import 'package:peeps/models/changed_status.dart';
import 'package:peeps/models/contribution.dart';

import 'package:peeps/resources/tasks_repository.dart';
import '../bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TimelineBloc timelineBloc;
  final TasksRepository repository;
  TaskBloc({
    @required this.repository,
    @required this.timelineBloc,
  });

  @override
  TaskState get initialState => InitialTaskState();

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is LoadTaskEvent) {
      yield LoadingTaskState();
      final data = await repository.readTasks();
      yield LoadedTaskState(data: data);
    }
    if (event is AddNewTaskEvent) {
      try {
        await repository.createTask(data: event.task.toJson());
        timelineBloc.add(SendDataTimelineEvent(
          intial: false,
          data: ContributionModel(
              who: event.task.creator,
              what: WhatEnum.create,
              when: DateTime.now(),
              how: "new",
              where: WhereEnum.task,
              why: "for ${event.assignment.title}",
              room: event.groupId, from: null, assignmentId:this.repository.data,taskId: null)));
        yield DisplayMessageSnackbar(color: "green", message: "Succeed");
      } catch (e) {
        yield DisplayMessageSnackbar(color: "red", message: e.toString());
      }
      yield InitialTaskState();
    }
    //Im too lazy to come out with new solution
    //From card_task delete button, deleting task button will be emit and listend on kanban then dispatch to delete task
    if (event is DeleteTaskEvent) {
      repository.deleteTask(id: event.taskId);
      yield InitialTaskState();
    }
    if (event is UpdateTaskEvent) {
      repository.updateTask(data: event.data.toJson());
      this.add(LoadTaskEvent());
    }
    if (event is UpdateTaskStatus) {
      List<dynamic> changedStatusTask = [];
      for (ChangedStatus task in event.tasks) {
        changedStatusTask.add(task.toJson());
        //TODO : Refactor these dumbdumb
        String currentStatus = "";
        String newStatus = "";
        if (task.previousStatus == 0) currentStatus = "todo";
        if (task.previousStatus == 1) currentStatus = "ongoing";
        if (task.previousStatus == 2) currentStatus = "done";

        if (task.status == 0) newStatus = "todo";
        if (task.status == 1) newStatus = "ongoing";
        if (task.status == 2) newStatus = "done";

        timelineBloc.add(SendDataTimelineEvent(
          intial: false,
          data: ContributionModel(
              who: task.by,
              what: WhatEnum.update,
              when: DateTime.now(),
              how: "${newStatus}",
              where: WhereEnum.task,
              why: "${currentStatus}", from: null, assignmentId: this.repository.data,taskId: null)));
      }
      repository.updateTaskStatus(data: changedStatusTask);
      yield DisplayMessageSnackbar(color: "green", message: "Saved");
      try {} catch (e) {}
      yield InitialTaskState();
    }
    if(event is RequestChangeAssignTo){
      repository.createRequest(data: event.data.toJson());
      timelineBloc.add(SendDataTimelineEvent(
        intial: false,
        data: ContributionModel(
          who: event.data.requester,
          when: event.data.createdDate,
          what: WhatEnum.request,
          where: WhereEnum.task,
          how: "",
          why: "", from: event.data.from,
          assignmentId: this.repository.data,taskId: null
        )
      )
        
      );
    }
  }
}
