import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class SupervisorMessagesBloc extends Bloc<SupervisorMessagesEvent, SupervisorMessagesState> {
  final GroupworkRepository repository;

  SupervisorMessagesBloc({
    @required this.repository
  });

  @override
  SupervisorMessagesState get initialState => InitialSupervisorMessagesState();

  @override
  Stream<SupervisorMessagesState> mapEventToState(
    SupervisorMessagesEvent event,
  ) async* {
    if(event is ReadSupervisorMessagesEvent){
      yield LoadingSupervisorMessagesState();
      var data = await repository.readSupervisorMessages();
      yield LoadedSupervisorMessagesState(data: data);

    }
    if(event is CreateSupervisorMessagesEvent){
      try{
        var message = await repository.createSupervisorMessages(data: {
          "group_id":repository.data,
          "data":event.data.toJson(),
        });
        yield MessageSupervisorMessagesState(data: message['message']);
      } catch(e){
        yield MessageSupervisorMessagesState(data: e);
      }

    }
  }
}
