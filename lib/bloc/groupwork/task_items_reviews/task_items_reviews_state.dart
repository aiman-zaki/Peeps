import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class TaskItemsReviewsState extends Equatable {
  const TaskItemsReviewsState();
}

class InitialTaskItemsReviewsState extends TaskItemsReviewsState {
  @override
  List<Object> get props => [];
}

class LoadingTasksItemsReviewsState extends TaskItemsReviewsState{
  @override
  String toString() => "LoadingTasksItemsReviewState";

  @override
  List<Object> get props => [];
}

class LoadedTasksItemsReviewsState extends TaskItemsReviewsState{
  final items;
  final reviews;

  LoadedTasksItemsReviewsState({
    @required this.items,
    @required this.reviews,
  });

  @override
  String toString() => "LoadedTasksItemsReviewsState";

  @override
  List<Object> get props => [];
}

class TaskItemsReviewsMessageState extends TaskItemsReviewsState{
  final message;

  TaskItemsReviewsMessageState({
    @required this.message
  });
  @override
  String toString() => "TaskItemsReviewsMessageState";

  @override
  List<Object> get props => [message];
}