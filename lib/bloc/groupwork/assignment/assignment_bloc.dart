import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peeps/enum/contribution_enum.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/contribution.dart';
import 'package:peeps/models/timeline.dart';
import 'package:peeps/resources/assignment_repository.dart';
import '../bloc.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final AssignmentRepository repository;
  final TimelineBloc timelineBloc;

  AssignmentBloc({
    @required this.repository,
    @required this.timelineBloc,
  });

  @override
  AssignmentState get initialState => InitialAssignmentState();

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Stream<AssignmentState> mapEventToState(
    AssignmentEvent event,
  ) async* {
    if(event is LoadAssignmentEvent){
      yield LoadingAssignmentState();
      final List<AssignmentModel> assignments = await repository.readAssignments();
      yield LoadedAssignmentState(data:assignments);
    }
    if(event is AddAssignmentEvent){
      await repository.createAssignment(data: event.assignment.toJson());
      timelineBloc.add(SendDataTimelineEvent(
        intial: true,
        data: ContributionModel(
          who: event.assignment.leader,
          what: WhatEnum.create,
          when: DateTime.now(),
          how: "new", where: WhereEnum.assignment, why: "",assignmentId: null,taskId: null,
          room: repository.data, from: null)));
    }
    if(event is TaskRefreshButtonClicked){
      yield LoadingAssignmentState();
      for(int i = 0 ;i<event.assignments.length;i++){
        if(event.assignments[i].id == event.latestAssignment.id){
          event.assignments[i] = event.latestAssignment;
        }
      }
      yield LoadedAssignmentState(data:event.assignments);
    }
    if(event is UpdateAssignmentStatusEvent){
      yield UpdatingAssignmentStatusState();
      await repository.updateAssignmentState(data: event.data);
      yield UpdatedAssignmentStatusState();
      print(event.data);
       timelineBloc.add(SendDataTimelineEvent(
         intial: false,
         data: ContributionModel(
            who: event.user,
            what: WhatEnum.update,
            when: DateTime.now(), 
            how: "status", 
            where: WhereEnum.assignment, 
            why: "from ongoing to done",
            taskId: null,
        room: repository.data, from: null, assignmentId: event.data['assignment_id'])));
      this.add(LoadAssignmentEvent());
    }
    if(event is DeleteAssignmentEvent){
      await repository.deleteAssignment(id: event.data);
       timelineBloc.add(SendDataTimelineEvent(
         intial: false,
         data: ContributionModel(
            who: event.user,
            what: WhatEnum.delete,
            when: DateTime.now()
          , how: "", where: WhereEnum.assignment, why: "",
          taskId: null,
        room: repository.data, from: null, assignmentId: event.data)));
    }
    if(event is UpdateAssignmentEvent){
      await repository.updateAssignment(data: event.data.toJson());
      this.add(LoadAssignmentEvent());
    }

 
  }
}
