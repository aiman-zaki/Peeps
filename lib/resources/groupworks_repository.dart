import 'package:meta/meta.dart';
import 'package:peeps/resources/base_respository.dart';

import 'common_repo.dart';

class GroupworksRepository extends BaseRepository{

  const GroupworksRepository():super(baseUrl:groupworksUrl);

  createGroupwork({@required data}) async {
    await super.create(data: data);
  }

}