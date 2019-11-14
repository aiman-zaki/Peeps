import 'package:meta/meta.dart';
import 'package:peeps/models/peer_review.dart';

class PeerReviewsModel{
  final String reviewer;
  final List peerReviews;


  PeerReviewsModel({
    @required this.reviewer,
    @required this.peerReviews,
  });


  static PeerReviewsModel fromJson(Map<String,dynamic> json){

    return PeerReviewsModel(
      reviewer: json['reviewer'],
      peerReviews: json['reviewed'].map((data){
        return PeerReviewModel.fromPeerReviewsJson(data,json['reviewer']);
      }).toList(),
    );
  }

}