import 'package:peeps/resources/base_respository.dart';
import 'package:meta/meta.dart';

import 'common_repo.dart';


class TimelineRepository extends BaseRepository{



  @override
  TimelineRepository({
    @required data,
  }):super(baseUrl:groupworksUrl,data:data);

  @override
  create({@required data,namespace}) async {
    await super.create(data:data.toJson());
  }

  @override
  delete() {
    // TODO: implement delete
    return null;
  }
  
}