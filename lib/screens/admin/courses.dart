import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/course.dart';
import 'package:peeps/resources/forum_repository.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/groupwork/collaborate/forum.dart';
import 'package:peeps/screens/splash_page.dart';


class CoursesListView extends StatefulWidget {
  CoursesListView({Key key}) : super(key: key);

  @override
  _CoursesListViewState createState() => _CoursesListViewState();
}

class _CoursesListViewState extends State<CoursesListView> {
  final codeController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<AdminCoursesBloc>(context);


    _showCourseFormDialog(data){
      if(data != null){
        codeController.text = data.code;
        nameController.text = data.name;
      }
      showDialog(
        context: context,
        builder: (context) => DialogWithAvatar(
          avatarIcon: Icon(Icons.add),
          height: 220,
          children: <Widget>[
            TextFormField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: "Course Code"
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Course Name"
              ),
            ),
          ],
          bottomRight: FlatButton(
            child: Text("Confirm"),
            onPressed: (){
              if(data != null){
                _bloc.add(UpdateCourseEvent(namespace:data.code,data: CourseModel(code: codeController.text,name: nameController.text)));
              } else {
                _bloc.add(CreateCourseEvent(data: CourseModel(
                    code: codeController.text,
                    name: nameController.text,
                  )));
              }
              Navigator.of(context).pop();
            },
          ),
        )
      );
    }

    _buildCoursesList(List<CourseModel> courses){
      return ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context,index){
          return Slidable(
            actionPane: SlidableScrollActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: "Update",
                icon: Icons.update,
                onTap: (){
                  _showCourseFormDialog(courses[index]);
                },
              )
            ],
            child: Card(
              child: ListTile(
                title: Text(courses[index].code),
                subtitle: Text(courses[index].name),
                onTap: (){
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => BlocProvider(
                        create: (BuildContext context) => CollaborateForumBloc(repository: ForumRepository(data: courses[index].code))..add(LoadForumEvent()),
                        child: CollaborateForumView(course: courses[index].code,isAdmin: true),
                        
                      )
                    )
                  );
                },
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
      ),
      body: BlocListener(
        bloc:_bloc,
        listener: (context,state){
          if(state is MessageCoursesState){
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        child: BlocBuilder(
          bloc: _bloc, 
          builder: (BuildContext context, state) {
            if(state is InitialAdminCoursesState){
              return SplashScreen();
            }
            if(state is LoadingAdminCoursesState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedAdminCoursesState){
              return _buildCoursesList(state.data);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showCourseFormDialog(null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}