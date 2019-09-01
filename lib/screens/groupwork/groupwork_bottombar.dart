import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/group_chat_bloc.dart';
import 'package:peeps/bloc/profile_bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/chat.dart';
import 'package:peeps/screens/groupwork/groupwork_hub.dart';
import 'package:peeps/screens/groupwork/kanban.dart';
import 'package:peeps/screens/groupwork/stash.dart';

import 'group_chat.dart';

class GroupworkBottomBar extends StatefulWidget {
  final GroupworkModel groupData;
  final UserModel userData;
  GroupworkBottomBar({Key key,@required this.groupData,this.userData}) : super(key: key);
  _GroupworkBottomBarState createState() => _GroupworkBottomBarState();
}

class _GroupworkBottomBarState extends State<GroupworkBottomBar> {

  GroupworkHub _groupworkhub;
  GroupChatView _groupChatView;
  StashView _stashView;
  Widget _showPage;

  Widget _pageSwitch(int index){
    switch(index){
      case(0):
        return _groupworkhub;
      case(1):
        return _groupChatView;
      case(2):
        return _stashView;
      default:
        return _groupworkhub;
    }
  }

  @override
  void initState() { 
    this._groupChatView = GroupChatView(room: widget.groupData.id,user: widget.userData,);
    _showPage = this._groupworkhub = GroupworkHub(groupData: widget.groupData);
    this._stashView = StashView();

    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider<GroupChatBloc>(builder: (context) => GroupChatBloc(chat: ChatResources(),)),
          BlocProvider<KanbanBoardBloc>(builder: (context) => KanbanBoardBloc(),),
          BlocProvider<StashBloc>(builder: (context) => StashBloc()),
        ],
        child: Scaffold(
          body: _showPage,
          bottomNavigationBar: CurvedNavigationBar(
            height: 50,
            color: Colors.blueAccent,
            backgroundColor: Colors.black,
            buttonBackgroundColor: Colors.black,
            items: <Widget>[
              Icon(Icons.developer_board),
              Icon(Icons.chat),
              Icon(Icons.storage),
            ],
            onTap: (index){
              setState(() {
                _showPage = _pageSwitch(index);
              });
            },
          ),
        )
    );
  }
}

