import 'package:peeps/models/discussion.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:meta/meta.dart';
class DiscussionRepository extends BaseRepositry{

  @override
  DiscussionRepository({
    @required namespace,
    @required data,
    @required data2,
  }):super(namespace:namespace,data:data,data2:data2);


  @override
  create(data)  async {

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
  update() {
    // TODO: implement update
    return null;
  }
  
}