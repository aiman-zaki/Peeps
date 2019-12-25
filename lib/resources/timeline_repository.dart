import 'package:peeps/models/contribution.dart';
import 'package:peeps/models/timeline.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:meta/meta.dart';

import 'common_repo.dart';


class TimelineRepository extends BaseRepository{

  @override
  TimelineRepository({
    @required data,
  }):super(baseUrl:groupworksUrl,data:data);

  
  read10Only({@required namespace}) async {
    var data = await super.read(namespace: namespace);
    List<ContributionModel> contributions = [];
    print(data);
    if(data != null){
      for(Map<String,dynamic> contribution in data){
        contributions.add(ContributionModel.fromJson(contribution));
      }
    }

    return contributions;
  
  }
  
  @override
  create({@required data,namespace}) async {
    await super.create(data:data.toJson(),namespace: "timelines");
  }



  
  
}