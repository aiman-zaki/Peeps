

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:peeps/models/message.dart';
import 'package:peeps/models/timeline.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:peeps/resources/socket_io.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

class LiveTimeline extends BaseSocketIO{

  BehaviorSubject _timelinesController;

  List<TimelineModel> _timelines = [];
  Sink get updateSink =>  _timelinesController.sink;
  Stream get timelineStream => _timelinesController.stream;
  List<TimelineModel> get timelines => _timelines;

  @override
  LiveTimeline({
    @required namespace,
    @required room,
  }):super(namespace:namespace,room:room);


  @override
  connect() async{
    await super.connect();
    _timelinesController = BehaviorSubject();
    this.streamData();
  }

  
  
  void sendData(TimelineModel timeline){
    socketIO.emit('send_data', [timeline.toJson()]);
  }

  void streamData(){
    socketIO.on('stream_data',(data){
      _timelines.add(TimelineModel.fromJson(data));
      updateSink.add(data);
    });
  }

  @override
  disconnect() async {
    super.disconnect();
    _timelinesController.close();

  }





}