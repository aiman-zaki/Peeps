import 'package:flutter/foundation.dart';

import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/peer_review.dart';
import 'package:peeps/models/peer_reviews.dart';
import 'package:peeps/models/question.dart';

import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/screens/groupwork/review/peer_review.dart';

import 'common_repo.dart';

class AssignmentRepository extends BaseRepository {
  @override
  const AssignmentRepository({
    @required data,
  }) : super(baseUrl: groupworksUrl, data: data);

  readAssignments() async {
    var data = await super.read(namespace: "assignments");
    List<AssignmentModel> assignments = [];
    for (Map<String, dynamic> assignment in data) {
      assignments.add(AssignmentModel.fromJson(assignment));
    }
    return assignments;
  }

  createAssignment({@required data}) async {
    await super.create(data: data, namespace: "assignments");
  }

  deleteAssignment({@required id}) async {
    await super.update(namespace: "assignments/delete",data: {
      'assignment_id':id
    });
  }

  updateAssignmentState({@required data}) async {
    await super.update(namespace: "assignments/status",data: data);
  }

  createPeerReview({@required data}) async {
    await super.create(data: data,namespace: "peer-review");
  }

  readPeerReview() async {
    var data = await super.read(namespace: "peer-review");
    if (data.isNotEmpty)
      return PeerReviewsModel.fromJson(data);
  
  }


}
