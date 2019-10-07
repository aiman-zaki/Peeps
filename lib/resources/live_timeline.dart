

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:peeps/models/message.dart';
import 'package:peeps/models/timeline.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

class LiveTimeline{
  SocketIOManager _manager;
  SocketIO _socketIO;
  String _room;
  bool isProbablyConnected = false;
  BehaviorSubject _timelinesController;

  List<TimelineModel> _timelines = [];
  Sink get updateSink =>  _timelinesController.sink;
  Stream get timelineStream => _timelinesController.stream;
  List<TimelineModel> get timelines => _timelines;



  Future connect({
    @required namespace,
    @required String room,
  }) async {

    isProbablyConnected = true;
    _timelinesController = BehaviorSubject();
    _manager = SocketIOManager();
    _room = room;
    _socketIO = await _manager.createInstance(SocketOptions(
      domain+namespace,
      enableLogging: true
    ));
    _socketIO.onConnect((data) async{
      String token = await accessToken();
      _socketIO.emit('join', [{'token':token,'room':_room}]);
      print("connected");
    });
    _socketIO.connect();
  }

  void sendData(TimelineModel timeline){
    _socketIO.emit('send_data', [timeline.toJson()]);
  }

  void streamData(){
    _socketIO.on('stream_data',(data){
      print("from stream_data $data");
      _timelines.add(TimelineModel.fromJson(data));
      print(_timelines.length);
      updateSink.add(data);
    });
  }

  void disconnect() async {
    isProbablyConnected = false;
    _timelinesController.close();
    await _manager.clearInstance(_socketIO);
  }





}