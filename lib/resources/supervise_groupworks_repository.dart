import 'package:meta/meta.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';

class SuperviseGroupworksRepository extends BaseRepository{
  SuperviseGroupworksRepository():super(baseUrl:supervisorUrl);

  readSuperviseGroupworks() async{
    var data = await super.read(namespace: 'groupworks');
    return data.map((groupwork){
      return GroupworkModel.fromJson(groupwork);
    }).toList().cast<GroupworkModel>();
  }
}