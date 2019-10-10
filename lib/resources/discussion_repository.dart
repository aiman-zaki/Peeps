import 'package:peeps/models/discussion.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/common_repo.dart';
class DiscussionRepository extends BaseRepositry{

  @override
  DiscussionRepository({
    @required data,
    @required data2,
  }):super(
    baseUrl:forumUrl,
    data:data,
    data2:data2);


  @override
  create(data)  async {
    await super.create(data);
  }

  @override
  read() async {
    var data = await super.read();
    return DiscussionModel.fromJson(data);
  }
  
  @override
  delete() {
    // TODO: implement delete
    return null;
  }

  @override
  update(data) async{
    await super.update(data);
  }
  
}