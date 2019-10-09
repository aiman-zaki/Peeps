import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/collaborate.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class CollaborateBloc extends Bloc<CollaborateEvent, CollaborateState> {
  
  final LiveCollaborate collaborate;

  CollaborateBloc({
    @required this.collaborate
  });
  
  @override
  CollaborateState get initialState => InitialCollaborateState();

  @override
  Stream<CollaborateState> mapEventToState(
    CollaborateEvent event,
  ) async* {
    if(event is InitialCollaborateEvent){
      yield InitializingCollaborateState();
      collaborate.connect();
      await Future.delayed(Duration(seconds: 1));
      collaborate.sendUsers(event.userData);
      yield InitializedCollaborateState(resource: collaborate);
    }
  }

  @override
  void dispose() {
    super.dispose();
    collaborate.disconnect();
  }
}
