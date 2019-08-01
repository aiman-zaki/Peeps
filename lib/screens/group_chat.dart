import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/main.dart';
import 'package:peeps/resources/chat.dart';


class GroupChatView extends StatefulWidget {
  GroupChatView({Key key}) : super(key: key);

  _GroupChatViewState createState() => _GroupChatViewState();
}



class _GroupChatViewState extends State<GroupChatView> {

  final ChatResources chat = ChatResources();
  
  Widget _buildGroupChat(){
    return ListView.builder(
          shrinkWrap: true,
          itemCount: chat.chats.length,
          itemBuilder: (BuildContext context,int index){
            return Text(chat.chats[index].toString());
          });
  }

  Widget _buildSender(){
    return Container(
      child: RaisedButton(
        onPressed: (){
          setState(() {
            chat.sendMessage("Test");
          });
        },
      ),
    );
  }

  void setup() async {
    await chat.connect(namespace: "group_chat",room: "test");
    chat.receiveMessage();
  }
  
  @override
  Widget build(BuildContext context) {
    final _groupchatBloc = BlocProvider.of<GroupChatBloc>(context);
    _groupchatBloc.dispatch(LoadGroupChatEvent(room: "test"));
    return Scaffold(
      appBar: new AppBar(
        title: Text("Group Chat"),
      ),
      body: BlocBuilder<GroupChatBloc,GroupChatState>(
        bloc: _groupchatBloc,
        builder: (BuildContext context,GroupChatState state){
          if(state is InitialGroupChatState){
            setup();
            return CircularProgressIndicator();
          } 
          if(state is LoadingGroupChatState){
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Loding Group Chat"),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          if(state is LoadedGroupChatState){
            return Column(
              children: <Widget>[
                _buildSender(),
                _buildGroupChat(),
                RaisedButton(
                  child: Text('Connect'),
                  onPressed: (){
                    setState(() {
                      chat.connect(namespace: "group_chat", room: "test");
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Disconnect"),
                  onPressed: (){
                    setState(() {
                      chat.disconnect();
                    });
                  },
                )

              ],
            );
          }
           return CircularProgressIndicator();
        },)
    );
  }
}