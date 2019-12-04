import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TaskItemsReviewsEvent extends Equatable {
  const TaskItemsReviewsEvent();
}

class ReadItemsReviewsEvent extends TaskItemsReviewsEvent{
  @override
  String toString() => "ReadItemsReviewsEvent";

  @override
  List<Object> get props => [];
}

class CreateItemsEvent extends TaskItemsReviewsEvent{
  final data;
  CreateItemsEvent({@required this.data});

  @override
  String toString() => "CreateItemsEvent";

  @override
  List<Object> get props => [];

}

class CreateReviewsEvent extends TaskItemsReviewsEvent{
  final data;
  CreateReviewsEvent({@required this.data});

  @override
  String toString() => "CreateReviewsEvent";

  @override
  List<Object> get props => [];
}

class UpdateReviewsApprovalEvent extends TaskItemsReviewsEvent{
  final data;
  UpdateReviewsApprovalEvent({
    @required this.data
  });
  
  @override
  String toString() => "UpdateReviewsEvent";


  @override
  List<Object> get props => [];
}