import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/timeline_assignment_repository.dart';
import './bloc.dart';

class AssignmentTimelineBloc extends Bloc<AssignmentTimelineEvent, AssignmentTimelineState> {
  TimelineAssignmentRepository repository;

  AssignmentTimelineBloc({
    @required this.repository
  });
  @override
  AssignmentTimelineState get initialState => InitialAssignmentTimelineState();

  @override
  Stream<AssignmentTimelineState> mapEventToState(
    AssignmentTimelineEvent event,
  ) async* {
    if(event is ReadAssignmentTimelineEvent){
      yield LoadingAssignmentTimelineState();
      var data = await repository.readContributions();
      print(data);
      yield LoadedAssignmentTimelineState(data: data);
    }
  }
}
