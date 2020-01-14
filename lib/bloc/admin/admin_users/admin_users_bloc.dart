import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/users_repository.dart';
import './bloc.dart';

class AdminUsersBloc extends Bloc<AdminUsersEvent, AdminUsersState> {
  final UsersRepository repository;

  AdminUsersBloc({
    @required this.repository,
  });

  @override
  AdminUsersState get initialState => InitialAdminUsersState();

  @override
  Stream<AdminUsersState> mapEventToState(
    AdminUsersEvent event,
  ) async* {
    if(event is ReadUsersEvent){
      yield LoadingAdminUsersState();
      var data = await repository.readUsers();
      yield LoadedAdminUsersState(data: data);
    }
  }
}
