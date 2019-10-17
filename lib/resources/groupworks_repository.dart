import 'package:meta/meta.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/base_respository.dart';

import 'common_repo.dart';

class GroupworksRepository extends BaseRepository{

  const GroupworksRepository():super(baseUrl:groupworksUrl);

  createGroupwork({@required data}) async {
    await super.create(data: data);
  }

  findGroupwork({@required data}) async {
    var response = await super.update(data: data,namespace: "search");
    List<GroupworkModel> groupworks = [];
    for(Map<String,dynamic> groupwork in response){
      groupworks.add(GroupworkModel.fromJson(groupwork));
    }

    return groupworks;
  
  }

}