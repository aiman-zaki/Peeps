import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/bloc/supervisor/bloc.dart';
import 'package:peeps/resources/s_groupwork_template.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class GroupworkTemplateSupervisorBloc extends Bloc<GroupworkTemplateSupervisorEvent, GroupworkTemplateSupervisorState> {
  final SGroupworkTemplateRepository repository;
  GroupworkTemplateSupervisorBloc({
    @required this.repository
  });
  
  @override
  GroupworkTemplateSupervisorState get initialState => InitialGroupworkTemplateSupervisorState();

  @override
  Stream<GroupworkTemplateSupervisorState> mapEventToState(
    GroupworkTemplateSupervisorEvent event,
  ) async* {
    if(event is ReadGroupworkTemplateSupervisorEvent){
      yield LoadingGroupworkTemplateSupervisorState();
      var data = await repository.readGroupworkTemplate();
      yield LoadedGroupworkTemplateSupervisorState(data: data);
    }
    if(event is CreateGroupworkTemplateSupervisorEvent){
      try{
         var message = await repository.createGroupworkTemplate(data: event.data.toJson());
         yield GroupworkTemplateSupervisorSucessState(message: message);
      }catch(e){
        yield GroupworkTemplateSupervisorErrorState(error: e);
      }
      this.add(ReadGroupworkTemplateSupervisorEvent());
    }
    if(event is UpdateGroupworkTemplateSupervisorEvent){
      try{
         var message = await repository.updateGroupworkTemplate(data: event.data.toJson());
         yield GroupworkTemplateSupervisorSucessState(message: message);
      }catch(e){
        yield GroupworkTemplateSupervisorErrorState(error: e);
      }
      this.add(ReadGroupworkTemplateSupervisorEvent());
    }
  }
}
