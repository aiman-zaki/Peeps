import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
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
import 'package:peeps/screens/groupwork/groupwork_hub/assignments.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/members.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/milestone.dart';
import 'package:peeps/screens/groupwork/invite_members.dart';

import '../assignment_form.dart';
import '../chat/group_chat.dart';
import '../profile/groupwork_profile.dart';
import '../kanban/kanban.dart';
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
    _isAdmin = checkIsAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget _captions({@required text}) {
      return Text(
        "$text",
        style: TextStyle(color: Colors.white30),
      );
    }

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

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Overview"),
          elevation: 0.00,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  child: ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        width: size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.purple[700],
                          Colors.purple[800],
                          Colors.purple[900],
                        ])),
                      ))),
              Positioned(
                  bottom: 0,
                  child: ClipPath(
                      clipper: WaveClipperTwo(reverse: true),
                      child: Container(
                        width: size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.purple[700],
                          Colors.purple[800],
                          Colors.purple[900],
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
                    HubMilestone(),
                    SizedBox(
                      height: 10,
                    ),
                    HubAssignments(
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
                    _stashOverview(),
                  ],
                ),
              )
            ],
          ),
        )
      );
  }
}
