import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/timeline/timeline_bloc.dart';
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
    }
    if(event is CreateReviewsEvent){
      await repository.updateTaskReview(data: event.data);
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
    }
  }
}
