import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/group_chat_bloc.dart';
import 'package:peeps/models/groupwork.dart';

import 'group_chat.dart';

class GroupworkDetailView extends StatefulWidget {
  final GroupworkModel data;
  
  GroupworkDetailView({Key key,@required this.data}) : super(key: key);

  _GroupworkDetailViewState createState() => _GroupworkDetailViewState();
}

class _GroupworkDetailViewState extends State<GroupworkDetailView> {
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
                  MaterialPageRoute(builder: (context) => BlocProvider<GroupChatBloc>.value(
                    value: GroupChatBloc(),
                    child: GroupChatView(),
                  )),
                );
              },
              child: Text("GroupChat"),
            )
          ],
        )
      ),
    );
  }
}