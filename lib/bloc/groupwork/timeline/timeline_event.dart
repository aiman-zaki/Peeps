import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class TimelineEvent extends Equatable {
  const TimelineEvent();
  @override
  List<Object> get props => [];
}


class ConnectTimelineEvent extends TimelineEvent{
  final data;

  ConnectTimelineEvent({
    @required this.data
  });

  @override
  String toString() => "ConnectTimelineEvent";
}

class DisconnectTimelineEvent extends TimelineEvent{
  @override
  String toString() => "DisconnectTimelineEvent";
}

class SendDataTimelineEvent extends TimelineEvent{
  final data;

  SendDataTimelineEvent({
    @required this.data,
  });

  @override
  String toString() => "SendDatTimelineEvent";
}

