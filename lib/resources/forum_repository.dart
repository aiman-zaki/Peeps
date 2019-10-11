
import 'package:peeps/models/discussion.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:meta/meta.dart';


class ForumRepository extends BaseRepository{


  ForumRepository({
    @required data,
  }):super(baseUrl:forumUrl,data:data);

  @override
  create({@required data,namespace}) async {
    await super.create(data:data.toJson());
  }


  @override
  read({namespace}) async {
    List discussions = [];
    var data = await super.read();
    for(Map<String,dynamic> discussion in data['discussions']){
      discussions.add(DiscussionModel.fromJson(discussion));
    }
    return discussions;
  }

  @override
  update({@required data,namespace}) async {
    // TODO: implement update
    return null;
  }

  
}