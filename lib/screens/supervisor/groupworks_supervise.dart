import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/supervisor/bloc.dart';
import 'package:peeps/bloc/supervisor/groupworks_supervise/groupworks_supervise_bloc.dart';
import 'package:peeps/models/course.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/assignment_repository.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/stash.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/common/tag.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/groupwork/stash/references.dart';
import 'package:peeps/screens/groupwork/stash/stash.dart';
import 'package:peeps/screens/splash_page.dart';
import 'package:peeps/screens/supervisor/complaints.dart';

import 'groupworks_messages_form.dart';

class GroupworksSuperviseView extends StatefulWidget {
  GroupworksSuperviseView({Key key}) : super(key: key);

  @override
  _GroupworksSuperviseViewState createState() => _GroupworksSuperviseViewState();
}

class _GroupworksSuperviseViewState extends State<GroupworksSuperviseView> {
  String filter;
  
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<GroupworksSuperviseBloc>(context);
    final _courseBloc = BlocProvider.of<CoursesSupervisorBloc>(context);
    final _size = MediaQuery.of(context).size;

    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    _showAnnouncementDialog(){
      final _supervisormessagebloc = BlocProvider.of<SupervisorMessagesBloc>(context);
      return DialogWithAvatar(
          width: _size.width,
          height: 220,
          avatarIcon: Icon(Icons.announcement),
          title: Text("Send Message to All Groupwork Members"),
          children: <Widget>[
            TextFormField(controller: titleController,),
            TextFormField(controller: bodyController,)
          ],
          bottomRight: FlatButton(
            onPressed: (){
              

            },
            child: Text("Confirm"),
          ),
        );
    }
  
    _buildSupevisorCoursesList(List<CourseModel> courses){
      return Column(
        children: <Widget>[
          Expanded(flex: 1,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Text("Courses",style: TextStyle(fontSize: 18),),
            ],
          ),),
          
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                      title: Text(courses[index].name),
                      trailing: Text(courses[index].code),
                      onTap: (){
                        setState(() {
                          filter = courses[index].code;
                        });
                      },
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    Widget _buildDrawerContent(){
      return BlocBuilder(
        bloc: _courseBloc,
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
        },
      );
    }

     Widget _buildAvatar(GroupworkModel groupwork){
      return Container(
        child: CustomNetworkProfilePicture(
          width: _size.width,
          bottomRadius: 0,
          topRadius: 10,
          image: groupwork.profilePicturerUrl,
          child: Center(child: Text(groupwork.name),),
        ),
      );
    }

    Widget _buildGroupworksList(List<GroupworkModel> data){
      return Container(
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Slidable(
                direction: Axis.vertical,
                actionPane: SlidableBehindActionPane(),
                secondaryActions: <Widget>[
                      IconSlideAction(
                        icon: Icons.assignment,
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<ReferenceBloc>(
                                    create: (context) => ReferenceBloc(stashRepository: StashRepository(data: data[index].id))
                                    ..add(ReadPublicReferencesEvent()),
                                    ),
                                  BlocProvider<AssignmentBloc>(
                                    create: (context) => AssignmentBloc(repository: AssignmentRepository(data: data[index].id),timelineBloc: null)..add(LoadAssignmentEvent()),
                                  )
                                ],
                                child: StashView(isPublic: true,)
                              )
                            )
                          );
                        },
                        caption: "Stash",
                      ),
                      IconSlideAction(
                        icon: Icons.timeline,
                        color: Colors.green,
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => BlocProvider(
                                create: (context) => ReferenceBloc(stashRepository: StashRepository(data: data[index].id))
                                ..add(ReadPublicReferencesEvent()),
                                child: Scaffold(
                                  appBar: AppBar(title: Text("Public References"),),
                                  body: Container(
                                    child: ReferencesView(isPublic: true,),
                                  ),
                                ),
                              )
                            )
                          );
                        },
                        caption: "Timelines",
                      ),
                      IconSlideAction(
                        icon: Icons.report,
                        color: Colors.red,
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<ComplaintBloc>(
                                    create: (context) => ComplaintBloc(repository: GroupworkRepository(data: data[index].id))),
                                ],
                                child: GroupworkComplaintView(complaints: data[index].complaints,),
                              )
                              )
                          );
                        },
                        caption: "Reports",
                      ),
                      IconSlideAction(
                        icon: Icons.announcement,
                        color: Colors.blue,
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => BlocProvider(
                              create: (context) => SupervisorMessagesBloc(repository: GroupworkRepository(data: data[index].id)),
                              child: GroupworksMessageForm(),
                            ))
                          );
                        },
                        caption: "Announcement",
                      )
                    ],
                child: Container(
                  child: Column(
                    children: <Widget>[
                      _buildAvatar(data[index])
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    _buildGroupworks(List<GroupworkModel> groupworks){
      return _buildGroupworksList(groupworks);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Groupworks Supervise"),
      ),
      endDrawer: Drawer(
        child: _buildDrawerContent(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder(
              bloc:_bloc,
              builder: (context,state){
                if(state is InitialGroupworksSuperviseState){
                  return SplashScreen();
                }
                if(state is LoadingGroupworksSuperviseState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is LoadedGroupworksSuperviseState){
                  if(state.data.isEmpty){
                    return Center(child: Text("No Data"),);
                  }
                  if(filter == null){
                    return _buildGroupworks(state.data);
                  }
                  final List<GroupworkModel> datas = []..addAll(state.data);
                  datas.removeWhere((item) => item.course != filter);
                  return _buildGroupworks(datas);
                   
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}