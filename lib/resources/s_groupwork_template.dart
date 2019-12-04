import 'package:meta/meta.dart';
import 'package:peeps/models/template.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:peeps/resources/supervisor_courses_repository.dart';

class SGroupworkTemplateRepository extends BaseRepository{
  SGroupworkTemplateRepository({
    @required data,
  }):super(baseUrl:supervisorUrl,data:data);

  readGroupworkTemplate() async {
    var data = await super.read(namespace: 'templates');
    return data.map((value){
      return GroupworkTemplateModel.fromJson(value);
    }).toList().cast<GroupworkTemplateModel>();
  }

  createGroupworkTemplate({@required data}) async {
    await super.create(namespace: 'templates',data: data);
  }

  updateGroupworkTemplate({@required data}) async {
    await super.update(namespace: 'templates',data: data);
  }
}