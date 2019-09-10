import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/resources/assignment_repository.dart';
import '../bloc.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final AssignmentRepository repository;

  AssignmentBloc({
    @required this.repository
  });

  @override
  AssignmentState get initialState => InitialAssignmentState();

  @override
  Stream<AssignmentState> mapEventToState(
    AssignmentEvent event,
  ) async* {
    if(event is LoadAssignmentEvent){
      yield LoadingAssignmentState();
      final List<AssignmentModel> assignments = await repository.fetchAllAssignments(groupId: event.groupId);
      yield LoadedAssignmentState(data:assignments);
    }
    if(event is AddAssignmentEvent){
      await repository.createAssignment(assignment: event.assignment.toJson(),groupId: event.groupId);
    }
    if(event is TaskRefreshButtonClicked){
      yield LoadingAssignmentState();
      //TODO 
      for(int i = 0 ;i<event.assignments.length;i++){
        if(event.assignments[i].id == event.latestAssignment.id){
          event.assignments[i] = event.latestAssignment;
        }
      }
      yield LoadedAssignmentState(data:event.assignments);

    }

 
  }
}
