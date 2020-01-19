import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}


class ReadStatsEvent extends StatsEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() => "ReadStatsEvent";
}