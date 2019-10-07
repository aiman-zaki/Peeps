import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class RequestState extends Equatable {
  const RequestState();
}

class InitialRequestState extends RequestState {
  @override
  List<Object> get props => [];
}


class LoadingRequestsState extends RequestState{
  @override
  String toString() => "LoadingRequestsState";

  @override
  List<Object> get props => [];
}

class LoadedRequestsState extends RequestState{
  final data;
  LoadedRequestsState({
    @required this.data,
  });
  @override
  String toString() => "LoadedRequestsState";

  @override
  List<Object> get props => [data];
}

class ProcessingRequestState extends RequestState{
  @override
  String toString() => "ProcessingRequestState";

  @override
  List<Object> get props => null;
}

class ProcessedRequestState extends RequestState{
  @override
  String toString() => "ProcessedRequestState";

  @override
  List<Object> get props => null;
}