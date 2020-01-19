import 'package:flutter/material.dart';
import 'package:peeps/models/contribution.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';

class TimelineAssignmentRepository extends BaseRepository{  

  TimelineAssignmentRepository({
    @required data,@required data2,
  }):super(baseUrl:groupworksUrl,data:data,data2:data2);


  readContributions() async {
    var data =  await super.read(namespace: "contributions");
    return data.map((contribution){
      return ContributionModel.fromJson(contribution);
    }).toList().cast<ContributionModel>();
  }

  readUserOnlyContributions() async {
    var data =  await super.read(namespace: "contributions/user");
    return data;
  }
}