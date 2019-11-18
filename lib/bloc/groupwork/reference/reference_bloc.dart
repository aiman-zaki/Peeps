import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/enum/contribution_enum.dart';
import 'package:peeps/models/contribution.dart';
import 'package:peeps/resources/stash.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class ReferenceBloc extends Bloc<ReferenceEvent, ReferenceState> {
  final StashRepository stashRepository;
  final TimelineBloc timelineBloc;

  ReferenceBloc({
    @required this.stashRepository,
    this.timelineBloc,
  });

  @override
  ReferenceState get initialState => InitialReferenceState();

  @override
  Stream<ReferenceState> mapEventToState(
    ReferenceEvent event,
  ) async* {
    if(event is ReadReferencesEvent){
      yield LoadingReferenceState();
      var data = await stashRepository.readReferences();
      yield LoadedReferenceState(data: data);
    }
    if(event is ReadPublicReferencesEvent){
      yield LoadingReferenceState();
      var data = await stashRepository.readPublicReferences();
      yield LoadedReferenceState(data: data);
    }
    if(event is CreateNewReferenceEvent){
      await stashRepository.createReference(data: event.data.toJson());
      timelineBloc.add(SendDataTimelineEvent(
        intial: false,
        data: ContributionModel(
        who: event.data.creator,
        what: WhatEnum.create,
        when: DateTime.now(),
        how: "new", where: WhereEnum.reference, why: "",
        room: stashRepository.data, from: null, assignmentId: null)));
      this.add(ReadReferencesEvent());
    }
  }
}
