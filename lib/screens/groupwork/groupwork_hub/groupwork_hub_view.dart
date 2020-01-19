import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/collaborate.dart';
import 'package:peeps/resources/forum_repository.dart';
import 'package:peeps/resources/groupworks_repository.dart';
import 'package:peeps/resources/marker_repository.dart';
import 'package:peeps/screens/groupwork/collaborate/bottom_bar.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/assignments.dart';
import 'package:peeps/screens/groupwork/collaborate/user_joined.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/live_timeline.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/members.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/milestone.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/welcome.dart';
import 'package:peeps/screens/groupwork/stash/stash.dart';

import 'header.dart';

enum Role{
  admin,
  normal,
}

class GroupworkHubView extends StatefulWidget {
  final GroupworkModel groupData;
  final UserModel userData;
  GroupworkHubView({Key key, this.groupData, this.userData}) : super(key: key);

  _GroupworkHubViewState createState() => _GroupworkHubViewState();
}

class _GroupworkHubViewState extends State<GroupworkHubView> {
  bool _isAdmin = false;

  bool checkIsAdmin(){

    for(Map<String,dynamic> member in widget.groupData.members){
      if(member['email'] == widget.userData.email){
        if(member['role'] == Role.admin.index){
          return true;
        }         
      }
    }
    return false;
  }



  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimelineBloc>(context).add(ConnectTimelineEvent(data: widget.groupData.id));
    BlocProvider.of<GroupChatBloc>(context).add(LoadGroupChatEvent(room: widget.groupData.id));
    SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(context: context,builder: (context) => WelcomeGroupworkHubDialog(groupwork: widget.groupData,)));
    _isAdmin = checkIsAdmin();
    
  }

  @override
  Widget build(BuildContext context) {
    final _assignmentBloc = BlocProvider.of<AssignmentBloc>(context);
    
    final _referencesBloc = BlocProvider.of<ReferenceBloc>(context);
    final size = MediaQuery.of(context).size;
    
    Widget _captions({@required text}) {
      return Text(
        "$text",
        style: TextStyle(color: Colors.white30),
      );
    }

    _collaborate(){
      return InkWell(
        onTap: (){
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<CollaborateMapBloc>(
                    create: (context) => CollaborateMapBloc(repository: MarkerRepository(data: widget.groupData.course))),
                  BlocProvider<CollaborateForumBloc>(
                    create: (context) => CollaborateForumBloc(repository: ForumRepository(data: widget.groupData.course),)),
                  BlocProvider<CollaborateBloc>(
                    create: (context) => CollaborateBloc(collaborate: LiveCollaborate(namespace: "collaborate",room: widget.groupData.course))),
                  BlocProvider<CollaborateGroupworkBloc>(
                    create: (context) => CollaborateGroupworkBloc(repository: GroupworksRepository()),
                  )
                  
                
                ],
                child: CollaborateBottomBarView(userData: widget.userData,course: widget.groupData.course,)),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(flex: 3, child: Text('Collaborate')),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<CollaborateMapBloc>(
                                    create: (context) => CollaborateMapBloc(repository: MarkerRepository(data: widget.groupData.course))),
                                  BlocProvider<CollaborateForumBloc>(
                                    create: (context) => CollaborateForumBloc(repository: ForumRepository(data: widget.groupData.course), )),
                                  BlocProvider<CollaborateBloc>(
                                    create: (context) => CollaborateBloc(collaborate: LiveCollaborate(namespace: "collaborate",room: widget.groupData.course))),
                                  BlocProvider<CollaborateGroupworkBloc>(
                                    create: (context) => CollaborateGroupworkBloc(repository: GroupworksRepository()),
                                  )
                                  
                                
                                ],
                                child: CollaborateBottomBarView(userData: widget.userData,course: widget.groupData.course,)),
                            ),
                          );
                        },
                        child: Icon(Icons.keyboard_arrow_right)
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    _stashOverview() {
      return InkWell(
        onTap: (){
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => BlocProvider.value(
                value: _referencesBloc,
                child: BlocProvider.value(value:_assignmentBloc, child: StashView(isPublic: false,)))
            )
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(flex: 3, child: Text('Stash')),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: _referencesBloc,
                                child: BlocProvider.value(value:_assignmentBloc,child: StashView(isPublic: false,)))
                            )
                          );
                        },
                        child: Icon(Icons.keyboard_arrow_right)
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Overview"),
          elevation: 1.00,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 1,
                  child: ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        width: size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.blue[700],
                          Colors.blue[800],
                          Colors.blue[900],
                        ])),
                      ))),
              Positioned(
                  bottom: 1,
                  child: ClipPath(
                      clipper: WaveClipperTwo(reverse: true),
                      child: Container(
                        width: size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.blue[700],
                          Colors.blue[800],
                          Colors.blue[900],
                        ])),
                      ))),
              Positioned(
                child: Column(
                  children: <Widget>[
                    HubHeader(
                      isAdmin: _isAdmin,
                      groupData: widget.groupData,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HubMilestoneView(),
                    SizedBox(
                      height: 10,
                    ),
                    LiveTimelineView(groupData: widget.groupData,),
                    
                    SizedBox(
                      height: 10,
                    ),
                    HubAssignments(
                      isAdmin: _isAdmin,
                      groupData: widget.groupData,
                      userData: widget.userData,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HubMembers(
                      groupData: widget.groupData,
                      userData: widget.userData,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: _stashOverview(),
                        ),
                        Expanded(
                          flex: 2,
                          child: _collaborate(),
                        )
                      ],
                    )
                   
                    
                  ],
                ),
              ),
            ],
          ),
        )
      );
  }
}
