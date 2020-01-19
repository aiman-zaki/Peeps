import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/models/contribution.dart';
import 'package:peeps/resources/timeline_assignment_repository.dart';
import 'package:peeps/resources/timeline_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class AssignmentTimelineUserBloc extends Bloc<AssignmentTimelineUserEvent, AssignmentTimelineUserState> {

  final TimelineAssignmentRepository timelineRepository;

  AssignmentTimelineUserBloc({
    @required this.timelineRepository,
  });

  @override
  AssignmentTimelineUserState get initialState => InitialAssignmentTimelineUserState();

  @override
  Stream<AssignmentTimelineUserState> mapEventToState(
    AssignmentTimelineUserEvent event,
  ) async* {
    if(event is ReadAssignmentTimelineUserEvent){
      yield LoadingAssignmentTimelineUserState();
      var data = await timelineRepository.readUserOnlyContributions();
      yield LoadedAssignmentTimelineUserState(
        score: data['score'],
        contributions: data['contributions'].map((contribution)
          => ContributionModel.fromJson(contribution)).toList().cast<ContributionModel>()
        );
      
    }
  }
}
