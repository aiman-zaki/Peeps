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
  void close() {
    super.close();
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
    if(event is DeleteAssignmentEvent){
      await repository.deleteAssignment(id: event.data);
    }

 
  }
}
