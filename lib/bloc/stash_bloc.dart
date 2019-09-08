import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
class StashBloc extends Bloc<StashEvent, StashState> {
  
  
  @override
  StashState get initialState => InitialStashState();

  @override
  Stream<StashState> mapEventToState(
    StashEvent event,
  ) async* {
    if(event is LoadStashEvent){
      yield LoadingStashState();
    



    }
  }
}
