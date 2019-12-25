import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();
}


class CreateComplaintEvent extends ComplaintEvent{
  final data;

  CreateComplaintEvent({
    @required this.data
  });

  @override
  String toString() => "CreateComplaintEvent";

  @override
  List<Object> get props => [];
}


class ReadComplaintsEvent extends ComplaintEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() => "ReadComplaintsEvent";
}