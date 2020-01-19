import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StatsState extends Equatable {
  const StatsState();
}

class InitialStatsState extends StatsState {
  @override
  List<Object> get props => [];
}

class LoadingStatsState extends StatsState{
  @override
  List<Object> get props => [];
}

class LoadedStatsState extends StatsState{
  final data;

  LoadedStatsState({
    @required this.data
  });

  @override
  List<Object> get props => [];
}
