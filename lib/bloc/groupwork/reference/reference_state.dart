import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class ReferenceState extends Equatable {
  const ReferenceState();
}

class InitialReferenceState extends ReferenceState {
  @override
  List<Object> get props => [];
}

class LoadingReferenceState extends ReferenceState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingReferenceState";
}

class LoadedReferenceState extends ReferenceState{
  final data;
  LoadedReferenceState({
    @required this.data
  });
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadedReferenceState";
}

class MessageReferenceState extends ReferenceState{
  final message;
  MessageReferenceState({
    @required this.message
  });
  @override
  String toString() => "MessageReferenceState";

  @override
  List<Object> get props => [];
}