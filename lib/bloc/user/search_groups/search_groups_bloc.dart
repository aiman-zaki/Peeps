import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/groupworks_repository.dart';
import 'package:peeps/resources/user_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import '../bloc.dart';

class SearchGroupsBloc extends Bloc<SearchGroupsEvent, SearchGroupsState> {
  final GroupworksRepository repository;
  final UserRepository usersRepository;

  SearchGroupsBloc({
    @required this.repository,
    @required this.usersRepository
  });
  
  @override
  SearchGroupsState get initialState => InitialSearchGroupsState();

  @override
  Stream<SearchGroupsState> mapEventToState(
    SearchGroupsEvent event,
  ) async* {
    if(event is SearchGroupsButtonClickedEvent){
      yield LoadingGroupsState();
      var data = await repository.read();
      yield LoadedGroupsState(data: data);
    }
    if(event is RequestGrouptEvent){
      yield RequestingGroupState();
      //await usersRepository.requestGroupwork(event.data);
      yield RequestedGroupState();
    }
  }
}
