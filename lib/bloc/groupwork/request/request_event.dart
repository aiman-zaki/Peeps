import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RequestEvent extends Equatable {
  const RequestEvent();
}

class LoadRequestsEvent extends RequestEvent{
  final data;

  LoadRequestsEvent({
    @required this.data
  });
  
  @override
  String toString () => "LoadingRequestsEvent";

  @override
  List<Object> get props => null;
}

class AnswerButtonClicked extends RequestEvent{
  final data;
  final groupId;
  AnswerButtonClicked({
    @required this.data,
    @required this.groupId,
  });

  @override
  List<Object> get props => [data];
}