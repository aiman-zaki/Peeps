import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ComplaintState extends Equatable {
  const ComplaintState();
}

class InitialComplaintState extends ComplaintState {
  @override
  List<Object> get props => [];
}


class LoadingComplaintsState extends ComplaintState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingComplaintState";
}

class LoadedComplaintsState extends ComplaintState{
  final data;
  LoadedComplaintsState({
    @required this.data
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadedComplaintState";
}

class MessageComplaintsState extends ComplaintState{
  final String message;

  MessageComplaintsState({
    @required this.message
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => "MessageComplaintsState";
}