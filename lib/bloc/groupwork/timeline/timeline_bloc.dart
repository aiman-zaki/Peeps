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
      var data = await repository.read10Only(namespace: 'timelines');
      await liveTimeline.connect();
      liveTimeline.initialTimelineData(data);
      yield ConnectedTimelineState(repo: liveTimeline);
    }
    if(event is DisconnectTimelineEvent){
    }
    if(event is SendDataTimelineEvent){
      event.data.room = repository.data;
      liveTimeline.sendData(event.data);
      if(!event.intial){
        await repository.create(data:event.data);
      }
    }
  }

  @override
  Future<void> close(){
    liveTimeline.disconnect();
    return super.close();
    
  }
}
