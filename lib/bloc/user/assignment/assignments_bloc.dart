import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/user_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class AssignmentsBloc extends Bloc<AssignmentsEvent, AssignmentsState> {
  final UserRepository repository;

  AssignmentsBloc({
    @required this.repository
  });
  @override
  AssignmentsState get initialState => InitialAssignmentsState();

  @override
  Stream<AssignmentsState> mapEventToState(
    AssignmentsEvent event,
  ) async* {
    if(event is LoadUserAssignmentsEvent){
      yield LoadingUserAssignmentsState();
      var data = await repository.readUserAssignment();
      yield LoadedUserAssignmentsState(data: data);
    }
  }
}
