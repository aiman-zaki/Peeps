import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SearchGroupsEvent extends Equatable {
  const SearchGroupsEvent();
}

class SearchGroupsButtonClickedEvent extends SearchGroupsEvent{
  final data;
  SearchGroupsButtonClickedEvent({
    @required this.data
  });
  
  @override
  String toString() => "SearchGroupsButtonClickedEvent";

  @override
  List<Object> get props => [data];
}

class RequestGrouptEvent extends SearchGroupsEvent{
  final data;
  RequestGrouptEvent({
    @required this.data
  });

  @override
  List<Object> get props => [];
}