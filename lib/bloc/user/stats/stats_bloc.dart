import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/user_repository.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final UserRepository repository;

  StatsBloc({
    @required this.repository
  });


  @override
  StatsState get initialState => InitialStatsState();

  @override
  Stream<StatsState> mapEventToState(
    StatsEvent event,
  ) async* {
    if(event is ReadStatsEvent){
      yield LoadingStatsState();
      var data = await repository.readOverallStats();
      yield LoadedStatsState(data:data);

    }
  }
}
