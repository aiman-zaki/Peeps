import 'package:equatable/equatable.dart';

abstract class TimelineState extends Equatable {
  const TimelineState();
  @override
  List<Object> get props => [];
}

class InitialTimelineState extends TimelineState {
  @override
  List<Object> get props => [];
}

class ConnectingTimelineState extends TimelineState{
  @override
  String toString() => "ConnectingTimelineState";
}

class ConnectedTimelineState extends TimelineState{
  final repo;


  ConnectedTimelineState({
    this.repo,
  });
  @override
  String toString() => "ConnectedTimelineState";
}
