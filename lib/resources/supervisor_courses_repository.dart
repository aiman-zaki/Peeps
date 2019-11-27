import 'package:peeps/models/course.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:meta/meta.dart';

class SupervisorRepository extends BaseRepository{
  SupervisorRepository():super(baseUrl:supervisorUrl);

  readCourses() async {
    var data = await super.read(namespace: 'courses');
    return data.map((value){
      return CourseModel.fromJson(value);
    }).toList().cast<CourseModel>();
  }

  updateCourses({@required data}) async {
    await super.create(data: data,namespace: 'courses');
  }

  
}