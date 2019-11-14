import 'package:equatable/equatable.dart';

abstract class GroupworksSuperviseEvent extends Equatable {
  const GroupworksSuperviseEvent();
}


class ReadGroupworksSuperviseEvent extends GroupworksSuperviseEvent{
  @override
  String toString() => "ReadGroupworksSuperviseEvent";

  @override
  List<Object> get props => [];
}

