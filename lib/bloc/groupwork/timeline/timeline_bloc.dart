import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/live_timeline.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/timeline_repository.dart';
import '../bloc.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {

  final LiveTimeline liveTimeline;
  final TimelineRepository repository;

  TimelineBloc({
    @required this.liveTimeline,
    @required this.repository,
  });

  @override
  TimelineState get initialState => InitialTimelineState();

  @override
  Stream<TimelineState> mapEventToState(
    TimelineEvent event,
  ) async* {
    if(event is ConnectTimelineEvent){
      yield ConnectingTimelineState();
      await liveTimeline.connect();
      yield ConnectedTimelineState(repo: liveTimeline);
    }
    if(event is DisconnectTimelineEvent){
      liveTimeline.disconnect();
    }
    if(event is SendDataTimelineEvent){
      liveTimeline.sendData(event.data);
      await repository.create(data:event.data);
    }
  }

  @override
  void dispose(){
    super.dispose();
    liveTimeline.disconnect();
  }
}
