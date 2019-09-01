import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/resources/assignment_repository.dart';
import './bloc.dart';

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
      List<AssignmentModel> assignments = await repository.fetchAssignment(groupId: event.groupId);
      yield LoadedAssignmentState(data:assignments);
    }
  }
}
