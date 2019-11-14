import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/supervise_groupworks_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class GroupworksSuperviseBloc extends Bloc<GroupworksSuperviseEvent, GroupworksSuperviseState> {
  final SuperviseGroupworksRepository repository;

  GroupworksSuperviseBloc({
    @required this.repository
  });
  @override
  GroupworksSuperviseState get initialState => InitialGroupworksSuperviseState();

  @override
  Stream<GroupworksSuperviseState> mapEventToState(
    GroupworksSuperviseEvent event,
  ) async* {
    if(event is ReadGroupworksSuperviseEvent){
      yield LoadingGroupworksSuperviseState();
      var data = await repository.readSuperviseGroupworks();
      yield LoadedGroupworksSuperviseState(data: data);
    }
  }
}
