import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PeerReviewState extends Equatable {
  const PeerReviewState();
}

class InitialPeerReviewState extends PeerReviewState {
  @override
  List<Object> get props => [];
}

class LoadingPeerReviewState extends PeerReviewState{
  @override
  List<Object> get props => [];
}

class LoadedPeerReviewState extends PeerReviewState{
  final data;
  LoadedPeerReviewState({
    @required this.data
  });
  @override
  List<Object> get props => [];
}