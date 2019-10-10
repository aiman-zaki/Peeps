import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/user_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class UserTaskBloc extends Bloc<UserTaskEvent, UserTaskState> {
  final UserRepository usersRepository;

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
      var data = await usersRepository.readUserOnlyTask();
      yield LoadedUserTaskState(data: data);
    }
  }
}
