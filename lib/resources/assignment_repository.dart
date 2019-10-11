import 'package:flutter/foundation.dart';

import 'package:peeps/models/assignment.dart';

import 'package:peeps/resources/base_respository.dart';

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
}
