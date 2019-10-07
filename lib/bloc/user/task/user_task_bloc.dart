import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class UserTaskBloc extends Bloc<UserTaskEvent, UserTaskState> {
  final UsersRepository usersRepository;

  UserTaskBloc({
    @required this.usersRepository,
  });
  
  @override
  UserTaskState get initialState => InitialUserTaskState();

  @override
  Stream<UserTaskState> mapEventToState(
    UserTaskEvent event,
  ) async* {
    if(event is LoadUserTaskEvent){
      yield LoadingUserTaskState();
      var data = await usersRepository.fetchCurrentUserOnlyTask();
      yield LoadedUserTaskState(data: data);
    }
  }
}
