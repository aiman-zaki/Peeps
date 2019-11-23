import 'package:peeps/models/discussion.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/common_repo.dart';
class DiscussionRepository extends BaseRepository{
  @override
  DiscussionRepository({
    @required data,
    @required data2,
  }):super(
    baseUrl:forumUrl,
    data:data,
    data2:data2);

  @override
  create({@required data,namespace})  async {
    await super.create(data:data);
  }

  @override
  read({namespace}) async {
    var data = await super.read(namespace: namespace);
    return DiscussionModel.fromJson(data);
  }

  @override
  update({@required data,namespace}) async{
    await super.update(data:data);
  }
}