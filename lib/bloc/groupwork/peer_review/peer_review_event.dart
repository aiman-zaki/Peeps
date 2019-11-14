import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class PeerReviewEvent extends Equatable {
  const PeerReviewEvent();
}


class LoadPeerReviewEvent extends PeerReviewEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadPeerReviewEvent";
}