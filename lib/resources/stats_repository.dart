import 'package:meta/meta.dart';
import 'package:peeps/resources/base_respository.dart';

import 'common_repo.dart';


class StatsRepository extends BaseRepository{
  StatsRepository():super(baseUrl:statsUrl);

  readUsersActivePerWeek() async{
    var data = await super.read(namespace: 'users/perweek');
    return data;
  }

}