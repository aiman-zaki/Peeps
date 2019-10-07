import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/timeline/bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/assignment_repository.dart';
import 'package:peeps/resources/chat.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/live_timeline.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/screens/common/custom_milestone.dart';
import 'package:peeps/screens/groupwork/assignment_form.dart';
import 'package:peeps/screens/groupwork/chat/group_chat.dart';
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
    return  MultiBlocProvider(
      providers: [
        BlocProvider<GroupChatBloc>(builder: (context) => GroupChatBloc(chat: ChatResources(),)),
        BlocProvider<KanbanBoardBloc>(builder: (context) => KanbanBoardBloc(),),
        BlocProvider<StashBloc>(builder: (context) => StashBloc()),
        BlocProvider<AssignmentBloc>(builder: (context) => AssignmentBloc(repository: const AssignmentRepository(),)),
        BlocProvider<MembersBloc>(builder: (context) => MembersBloc(repository: const GroupworkRepository()),),
        BlocProvider<GroupProfileBloc>(builder: (context) => GroupProfileBloc(repository: const GroupworkRepository()),),
        BlocProvider<InviteMembersBloc>(builder: (context) => InviteMembersBloc(repository: const UsersRepository(), groupworkRepository: const GroupworkRepository()),),
        BlocProvider<TimelineBloc>(builder: (context) => TimelineBloc(liveTimeline: LiveTimeline()),)
        
      ],
      child: GroupworkHubView(groupData:widget.groupData,userData:widget.userData)
    );
  }
}