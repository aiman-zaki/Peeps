import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/supervisor/bloc.dart';
import 'package:peeps/models/course.dart';
import 'package:peeps/resources/s_groupwork_template.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/splash_page.dart';

import 'groupwork_template.dart';

class CoursesSuperviseView extends StatefulWidget {
  CoursesSuperviseView({Key key}) : super(key: key);

  @override
  _CoursesSuperviseViewState createState() => _CoursesSuperviseViewState();
}

class _CoursesSuperviseViewState extends State<CoursesSuperviseView> {
  
  final _courseController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CoursesSupervisorBloc>(context);

    _showAddCourseDialog(){
      showDialog(
        context: context,
        builder: (context){
          return DialogWithAvatar(
            avatarIcon: Icon(Icons.add),
            title: Text("Add Course"),

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(controller: _courseController,decoration: InputDecoration(
                      labelText: "Course",
                      ),
                ),
              )
            ],
            bottomRight: FlatButton(
              child: Text("Confirm"),
              onPressed: (){
                _bloc.add(UpdateCoursesSupervisorEvent(data: _courseController.text));
              },
            ),
          );
        }
      );
    }

    _buildSupevisorCoursesList(List<CourseModel> courses){
      return Container(
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                  title: Text(courses[index].name),
                  trailing: Text(courses[index].code),
                  onTap: (){
                    Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) => 
                        BlocProvider(create: (context) => 
                          GroupworkTemplateSupervisorBloc(
                            repository: SGroupworkTemplateRepository(data: courses[index].code))
                            ..add(ReadGroupworkTemplateSupervisorEvent()),child: SupervisorGroupworkTemplateView(),)
                          )
                    );
                  },
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),

      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (context,state){
          if(state is MessageCoursesSupervisorState){
            Scaffold.of(context).showSnackBar(SnackBar(content: state.message,));
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context,state){
            if(state is InitialCoursesSupervisorState){
              return SplashScreen();
            }
            if(state is LoadingCoursesSupervisorState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedCoursesSupervisorState){
              return _buildSupevisorCoursesList(state.data);
            }
          }),
      ),
        floatingActionButton: FloatingActionButton(
          heroTag: "course-template",
          child: Icon(Icons.add),
          onPressed: (){
            _showAddCourseDialog();
          },
        ),
    );
  }
}