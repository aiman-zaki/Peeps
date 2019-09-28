import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import '../bloc.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  final GroupworkRepository repository;

  MembersBloc({
    @required this.repository
  });

  @override
  MembersState get initialState => InitialMembersState();

  @override
  Stream<MembersState> mapEventToState(
    MembersEvent event,
  ) async* {
    if(event is LoadMembersEvent){
      yield LoadingMembersState();
      var members = await repository.fetchMembers(event.groupId);
      yield LoadedMembersState(data: members);
    }
    
  }
}
