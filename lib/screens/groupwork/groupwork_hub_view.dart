import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/member.dart';
import 'package:peeps/models/members.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/common/custom_milestone.dart';
import 'package:peeps/screens/common/custom_stack_background.dart';
import 'package:peeps/screens/common/custom_stack_front.dart';
import 'package:peeps/screens/groupwork/invite_members.dart';

import 'assignment_form.dart';
import 'group_chat.dart';
import 'groupwork_profile.dart';
import 'kanban.dart';

class GroupworkHubView extends StatefulWidget {
  final GroupworkModel groupData;
  final UserModel userData;
  GroupworkHubView({Key key, this.groupData, this.userData}) : super(key: key);

  _GroupworkHubViewState createState() => _GroupworkHubViewState();
}

class _GroupworkHubViewState extends State<GroupworkHubView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _groupChatBloc = BlocProvider.of<GroupChatBloc>(context);
    final _assignmentBloc = BlocProvider.of<AssignmentBloc>(context);
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);
    final _groupProfileBloc = BlocProvider.of<GroupProfileBloc>(context);
    final size = MediaQuery.of(context).size;

    _stashOverview() {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        elevation: 8,
        color: Colors.grey[900],
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
                      onPressed: () {},
                      child: Text(
                        'Add',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    //TODO : Brainstorm Feature
    _brainstorm() {}
    _buildMembersList(List<MemberModel> data) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context,index){
          return ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            child: CustomNetworkProfilePicture(
              width: 120,
              heigth: 120,
              image: data[index].profilePicture,
            ),
          ),
            title: Text(data[index].email),
          trailing: InkWell(onTap:(){},child: Text("Chat"),),
          );
        }
      );
    }

    //TODO : Members
    _members() {
      return Card(
        elevation: 8,
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(flex: 4, child: Text('Members',
                    style: TextStyle(fontSize: 16),)),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<MembersBloc>.value(
                                      value: _membersBloc,
                                      child: InviteMembersView()),
                              fullscreenDialog: true),
                        );
                      },
                      child: Text(
                        'Invite',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              BlocBuilder<MembersBloc, MembersState>(
                bloc: _membersBloc,
                builder: (context, state) {
                  if (state is InitialMembersState) {
                    _membersBloc.dispatch(
                        LoadMembersEvent(groupId: widget.groupData.id));
                    return Container();
                  }
                  if (state is LoadingMembersState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is LoadedMembersState) {
                    return _buildMembersList(state.data);
                  }
                  return Container();
                },
              ),
              Divider(),
              SizedBox(
                  width: double.maxFinite,
                  child: FlatButton(
                    child: Text("Group Chat"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          child: GroupChatView(
                            room: widget.groupData.id,
                            user: widget.userData,
                          ),
                          value: _groupChatBloc,
                        ),
                      ));
                    },
                  ))
            ],
          ),
        ),
      );
    }

    _buildAssignmentList(List<AssignmentModel> data) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context,index){
          if(data.length != 0){
            return ExpandablePanel(
            tapBodyToCollapse: true,
            header: Text(data[index].title,style: TextStyle(
              fontSize: 15,
           
            ),),
              collapsed: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    onTap: (){
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => BlocProvider<TaskBloc>.value(
                            value: _taskBloc,
                            child: KanbanBoardView(
                              data: data[index],
                              groupId: widget.groupData.id,
                            ),
                          ),
                        )
                      );
                    },
                    leading: Icon(Icons.developer_board),
                    title: Text("Kanban Board"),
                  ),
                ],
              ),
              expanded: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.dashboard),
                    title:  Text("Description"),
                    subtitle: Text(data[index].description),
                  ),
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text("Leader"),
                    subtitle: Text(data[index].leader),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text("Due Date"),
                    subtitle: Text("2019/9/13"),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: FlatButton(
                          onPressed: (){},
                          child: Text("Leader Stuff"),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 20,)
                ],
              )
            );
          } else {
            return Container(
              width: size.width,
              child: Text("No Assignments"),
            );
          }  
        },
      );
    }

    _buildAssignmentOverview() {
      return Card(
        elevation: 8,
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: <Widget>[
                          Text('Assignments',style: TextStyle( 
                            color: Colors.lightBlue,
                            fontSize: 16),),
                          SizedBox(width: 10,),
                          InkWell(
                              onTap: () {
                                _assignmentBloc.dispatch(LoadAssignmentEvent(
                                    groupId: widget.groupData.id));
                              },
                              child: Icon(Icons.refresh)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                                value: _assignmentBloc,
                                child: AssignmentFormView(
                                  groupId: widget.groupData.id,
                                )),
                            fullscreenDialog: true,
                          ));
                        },
                        child: Text(
                          "New",
                          textAlign: TextAlign.center,
                        )
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: BlocBuilder<AssignmentBloc, AssignmentState>(
                  builder: (BuildContext context, AssignmentState state) {
                    if (state is InitialAssignmentState) {
                      _assignmentBloc.dispatch(
                          LoadAssignmentEvent(groupId: widget.groupData.id));
                      return Container();
                    }
                    if (state is LoadingAssignmentState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is LoadedAssignmentState) {
                      return _buildAssignmentList(state.data);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );
    }

    _buildMilestone() {
      return Card(
        elevation: 8,
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Milestone',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomMilestone(
                totalGoals: 5,
                completedGoals: 2,
                icon: Icons.check_circle_outline,
                completedIcon: Icons.check,
              ),
              SizedBox(
                height: 2,
              ),
            ],
          ),
        )
      );
    }

    _buildHeader(){
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
        color: Colors.grey[900],
        child: Container(
          width: size.width,
          height: 120,
          padding: const EdgeInsets.all(9.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10,
                right: 50,
                child: Column(
                  children: <Widget>[
                    Text(
                      "id : ${widget.groupData.id}",
                      style: TextStyle(
                          fontSize: 11, color: Colors.cyan[300]),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      widget.groupData.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 22
                      ),
                    ),
                  ],
                )
              ),
              Positioned(
                top: 10,
                bottom: 10,
                right: 10,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: _groupProfileBloc,
                          child: GroupworkProfile(
                            data: widget.groupData,
                          )),
                        fullscreenDialog: true),
                    );
                  },
                  child: Icon(Icons.keyboard_arrow_right)),
              ),
              Positioned(
                top: 10,
                left: 10,
                bottom: 10,
                child: Hero(
                  tag: "dp",
                  child: CustomNetworkProfilePicture(
                    heigth: 90.00,
                    width: 90.00,
                    image: widget.groupData.profilePicturerUrl,
                    child: Container(),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text("Overview"),
        elevation: 0.00,
      ),
      body: SingleChildScrollView(
       
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: CustomStackBackground(
                color: Colors.blue[600],
                width: size.width,
                height: size.height/2,
                child: Container(),
              ),
            ),
            Positioned(
              child: CustomStackFrontBody(
                color: Colors.grey[900],
                width: size.width,
                child: Column(
                  children: <Widget>[
                    _buildHeader(),
                    _buildMilestone(),
                    _buildAssignmentOverview(),
                    _members(),
                    _stashOverview(),
                  ],
                ),
              ),
            )
          ],
        ),
      ));
  }
}
