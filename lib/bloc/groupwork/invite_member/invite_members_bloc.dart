import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/groupworks_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import '../bloc.dart';
import 'package:meta/meta.dart';
class InviteMembersBloc extends Bloc<InviteMembersEvent, InviteMembersState> {
  final UsersRepository repository;
  final GroupworkRepository groupworkRepository;
  InviteMembersBloc({
    @required this.repository,
    @required this.groupworkRepository
  });
  
  @override
  InviteMembersState get initialState => InitialInviteMembersState();

  @override
  Stream<InviteMembersState> mapEventToState(
    InviteMembersEvent event,
  ) async* {
    if(event is SearchButtonClickedEvent){
      yield LoadingUsersState();
      var data = await repository.find(data:{
        "search":event.data,
      });
      yield LoadedUsersState(data: data);
    }
    if(event is InviteMemberEvent){
      yield InvitingMemberState();
      await groupworkRepository.createMembers(data:event.data);
      yield InvitedMemberState();
    }
  }
}
