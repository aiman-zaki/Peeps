import 'package:peeps/resources/base_respository.dart';
import 'package:meta/meta.dart';

import 'common_repo.dart';


class TimelineRepository extends BaseRepositry{



  @override
  TimelineRepository({
    @required namespace,
    @required data,
  }):super(baseUrl:groupworkUrl,namespace:namespace,data:data);

  @override
  create(data) async {
    await super.create(data.toJson());
  }

  @override
  delete() {
    // TODO: implement delete
    return null;
  }
  
}