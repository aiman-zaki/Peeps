import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/groupworks_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class CollaborateGroupworkBloc extends Bloc<CollaborateGroupworksEvent, CollaborateGroupworksState> {
  final GroupworksRepository repository;

  CollaborateGroupworkBloc({
    @required this.repository
  });

  @override
  CollaborateGroupworksState get initialState => InitialCollaborateGroupworksState();

  @override
  Stream<CollaborateGroupworksState> mapEventToState(
    CollaborateGroupworksEvent event,
  ) async* {
    if(event is ReadCollaborateGroupworksEvent){
      yield LoadingCollaborateGroupworksState();
      var data = await repository.findGroupwork(data: event.data);
      yield LoadedCollaborateGroupworksState(data: data);
    }
  }
}
