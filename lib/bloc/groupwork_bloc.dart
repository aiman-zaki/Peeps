import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class GroupworkBloc extends Bloc<GroupworkEvent, GroupworkState> {
  @override
  GroupworkState get initialState => InitialGroupworkState();

  @override
  Stream<GroupworkState> mapEventToState(
    GroupworkEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
