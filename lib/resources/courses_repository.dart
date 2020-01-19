import 'package:meta/meta.dart';
import 'package:peeps/models/course.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';


class CoursesRepository extends BaseRepository{
  CoursesRepository():super(baseUrl:coursesUrl);

  readCourses() async {
    var data = await super.read();
    return data.map((course) => CourseModel.fromJson(course)).toList().cast<CourseModel>();
  }

  createCourse({@required data}) async {
    var message = await super.create(data: data);
    return message;
  }

  updateCourse({@required data,@required namespace}) async {
    var message = await super.update(data: data,namespace: namespace);
    return message;
  }
}