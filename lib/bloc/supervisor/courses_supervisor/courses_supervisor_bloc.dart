import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/supervisor_courses_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class CoursesSupervisorBloc extends Bloc<CoursesSupervisorEvent, CoursesSupervisorState> {

  final SupervisorRepository repository;
  CoursesSupervisorBloc({
    @required this.repository
  });


  @override
  CoursesSupervisorState get initialState => InitialCoursesSupervisorState();

  @override
  Stream<CoursesSupervisorState> mapEventToState(
    CoursesSupervisorEvent event,
  ) async* {
    if(event is ReadCoursesSupervisorEvent){
      yield LoadingCoursesSupervisorState();
      var data = await repository.readCourses();
      yield LoadedCoursesSupervisorState(data: data);
    }
    if(event is UpdateCoursesSupervisorEvent){
      await repository.updateCourses(data:event.data);
    }
  }
}
