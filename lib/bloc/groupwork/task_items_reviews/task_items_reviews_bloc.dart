import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/timeline/timeline_bloc.dart';
import 'package:peeps/bloc/groupwork/timeline/timeline_event.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/enum/contribution_enum.dart';
import 'package:peeps/models/contribution.dart';
import 'package:peeps/resources/task_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class TaskItemsReviewsBloc extends Bloc<TaskItemsReviewsEvent, TaskItemsReviewsState> {
  final TimelineBloc timelineBloc;
  final TaskRepository repository;
  TaskItemsReviewsBloc({
    @required this.timelineBloc,
    @required this.repository,
  });
  @override
  TaskItemsReviewsState get initialState => InitialTaskItemsReviewsState();

  @override
  Stream<TaskItemsReviewsState> mapEventToState(
    TaskItemsReviewsEvent event,
  ) async* {
    if(event is CreateItemsEvent){
      await repository.updateTaskItems(data: event.data);
      this.add(ReadItemsReviewsEvent());
      timelineBloc.add(SendDataTimelineEvent(
      intial: false,
      data: ContributionModel(
      who: event.data.by,
      what: WhatEnum.create,
      when: DateTime.now(),
      how: "new", where: WhereEnum.material, why: "",
      room: repository.data, from: null, assignmentId: repository.data,taskId: repository.data2)));
    }
    if(event is CreateReviewsEvent){
      await repository.updateTaskReview(data: event.data);
          timelineBloc.add(SendDataTimelineEvent(
          intial: false,
          data: ContributionModel(
          who: event.data.by,
          what: WhatEnum.create,
          when: DateTime.now(),
          how: "new", where: WhereEnum.suggestion, why: "",
          room: repository.data, from: "", assignmentId: repository.data,taskId: repository.data2)));
      this.add(ReadItemsReviewsEvent());
    }
    if(event is ReadItemsReviewsEvent){
      yield LoadingTasksItemsReviewsState();
      var items = await repository.readTaskItems();
      var reviews = await repository.readTaskReviews();
      yield LoadedTasksItemsReviewsState(items: items,reviews: reviews);
    }
    if(event is UpdateReviewsApprovalEvent){
      await repository.updateTaskReviewApproval(data: event.data);
      WhatEnum whatEnum = WhatEnum.accept;
      if(event.data.approval != Approval.approved)
        whatEnum = WhatEnum.deny;
        timelineBloc.add(SendDataTimelineEvent(
              intial: false,
              data: ContributionModel(
              who: event.data.by,
              what: whatEnum,
              when: DateTime.now(),
              how: "", where: WhereEnum.task, why: "suggestion",
              room: repository.data, from: "", assignmentId: repository.data,taskId: repository.data2)));
      
        
      
    }
    if(event is AcceptTaskSolutionsEvent){
      await repository.updateAcceptTaskSolution(data: event.data);
          timelineBloc.add(SendDataTimelineEvent(
            intial: false,
            data: ContributionModel(
            who: event.data['by'],
            what: WhatEnum.accept,
            when: DateTime.now(),
            how: "", where: WhereEnum.task, why: "solution",
            room: repository.data, from: "", assignmentId: repository.data,taskId: repository.data2)));
    }
  }
}
