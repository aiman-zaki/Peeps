import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/models/contribution.dart';
import 'package:peeps/resources/stash.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class ReferenceBloc extends Bloc<ReferenceEvent, ReferenceState> {
  final StashRepository stashRepository;
  final TimelineBloc timelineBloc;

  ReferenceBloc({
    @required this.stashRepository,
    @required this.timelineBloc,
  });

  @override
  ReferenceState get initialState => InitialReferenceState();

  @override
  Stream<ReferenceState> mapEventToState(
    ReferenceEvent event,
  ) async* {
    if(event is LoadReferencesEvent){
      yield LoadingReferenceState();
      var data = await stashRepository.readReferences();
      yield LoadedReferenceState(data: data);
    }
    if(event is CreateNewReferenceEvent){
      await stashRepository.createReference(data: event.data.toJson());
      timelineBloc.add(SendDataTimelineEvent(data: ContributionModel(
        who: event.data.creator,
        what: "create",
        when: DateTime.now()
      , how: "new", where: "Reference", why: "",
        room: stashRepository.data)));
      this.add(LoadReferencesEvent());
    }
  }
}
