import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/courses_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class AdminCoursesBloc extends Bloc<AdminCoursesEvent, AdminCoursesState> {
  final CoursesRepository coursesRepository;

  AdminCoursesBloc({
    @required this.coursesRepository
  });

  @override
  AdminCoursesState get initialState => InitialAdminCoursesState();

  @override
  Stream<AdminCoursesState> mapEventToState(
    AdminCoursesEvent event,
  ) async* {
    if(event is ReadCoursesEvent){
      yield LoadingAdminCoursesState();
      var data = await coursesRepository.readCourses();
      yield LoadedAdminCoursesState(data: data);
    }
    if(event is CreateCourseEvent){
      try{
        var message = await coursesRepository.createCourse(data: event.data.toJson());
        yield MessageCoursesState(message: message['message']);
      } catch(e){
        yield MessageCoursesState(message: e);
      }
      this.add(ReadCoursesEvent());
    }
    if(event is UpdateCourseEvent){
      try{
        var message = await coursesRepository.updateCourse(data:event.data.toJson(), namespace: event.namespace);
          yield MessageCoursesState(message: message['message']);
        } catch(e){
          yield MessageCoursesState(message: e);
        }
        this.add(ReadCoursesEvent());
      }
    }
}
