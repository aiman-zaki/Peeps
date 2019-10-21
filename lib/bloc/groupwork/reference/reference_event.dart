import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class ReferenceEvent extends Equatable {
  const ReferenceEvent();
}

class LoadReferencesEvent extends ReferenceEvent{
  @override
  String toString() => "LoadReferenecEvent";

  @override
  List<Object> get props => [];
}

class CreateNewReferenceEvent extends ReferenceEvent{
  final data;
  CreateNewReferenceEvent({
    @required this.data
  });
  @override
  String toString() => "CreateNewRefernceEvent";

  @override
  List<Object> get props => [];
}