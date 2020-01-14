import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';

import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/assignment_repository.dart';
import 'package:peeps/resources/chat.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/live_timeline.dart';
import 'package:peeps/resources/stash.dart';
import 'package:peeps/resources/timeline_repository.dart';
import 'package:peeps/resources/users_repository.dart';

import 'package:peeps/screens/groupwork/groupwork_hub/groupwork_hub_view.dart';

class GroupworkHub extends StatefulWidget {
  final GroupworkModel groupData;
  final UserModel userData;
  GroupworkHub({Key key, this.groupData,this.userData}) : super(key: key);

  _GroupworkHubState createState() => _GroupworkHubState();
}

class _GroupworkHubState extends State<GroupworkHub> with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this); 

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final _timelineBloc = BlocProvider.of<TimelineBloc>(context);
    
    return  MultiBlocProvider(
      providers: [
        BlocProvider<GroupChatBloc>(create: (context) => GroupChatBloc(chat: ChatResources(namespace: 'group_chat',room: widget.groupData.id),)),
        BlocProvider<KanbanBoardBloc>(create: (context) => KanbanBoardBloc(),),
        BlocProvider<AssignmentBloc>(create: (context) => AssignmentBloc(repository: AssignmentRepository(data: widget.groupData.id), timelineBloc: _timelineBloc),),
        BlocProvider<MembersBloc>(create: (context) => MembersBloc(repository: GroupworkRepository(data: widget.groupData.id)),),
        BlocProvider<GroupProfileBloc>(create: (context) => GroupProfileBloc(repository: GroupworkRepository(data: widget.groupData.id)),),
        BlocProvider<InviteMembersBloc>(create: (context) => InviteMembersBloc(repository: const UsersRepository(), groupworkRepository:  GroupworkRepository(data: widget.groupData.id)),),
        BlocProvider<ReferenceBloc>(create: (context) => ReferenceBloc(stashRepository: StashRepository(data:widget.groupData.id), timelineBloc: _timelineBloc),),
        BlocProvider<ComplaintBloc>(create: (context) => ComplaintBloc(repository: GroupworkRepository(data: widget.groupData.id)),),
        BlocProvider<TimelineBloc>.value(value: _timelineBloc,)
      ],
      child: GroupworkHubView(groupData:widget.groupData,userData:widget.userData)
    );
  }
}