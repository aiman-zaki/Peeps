import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/group_chat_bloc.dart';
import 'package:peeps/bloc/profile_bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/chat.dart';
import 'package:peeps/screens/kanban.dart';

import 'group_chat.dart';

class GroupworkDetailView extends StatefulWidget {
  final GroupworkModel data;
  
  GroupworkDetailView({Key key,@required this.data}) : super(key: key);

  _GroupworkDetailViewState createState() => _GroupworkDetailViewState();
}

class _GroupworkDetailViewState extends State<GroupworkDetailView> {
  UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.data.name),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BlocProvider<GroupChatBloc>(
                    builder: (context) => GroupChatBloc(chat: ChatResources()),
                    child: GroupChatView(room: widget.data.id,user: user,),
                  )),
                );
              },
              child: Text("GroupChat"),
            ),
            new RaisedButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => KanbanBoardView()),
                );
              },
              child: Text("KanbanBoard"),
            )
          ],
        )
      ),
    );
  }
  @override 
  void initState() {
    // TODO: MORE RESEARCH
    BlocProvider.of<ProfileBloc>(context).state.listen((state){
      if(state is ProfileLoaded){
        user = state.data;
      }
    });
    super.initState();
  }
}