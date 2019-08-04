import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/main.dart';
import 'package:peeps/resources/chat.dart';

class GroupChatView extends StatefulWidget {
  GroupChatView({Key key}) : super(key: key);

  _GroupChatViewState createState() => _GroupChatViewState();
}



class _GroupChatViewState extends State<GroupChatView> with WidgetsBindingObserver {
  ChatResources chat;
  final _senderController = TextEditingController();
 

  Widget _buildGroupChat(){
    return Expanded(
      flex: 4,
      child: StreamBuilder(
        stream: chat.chatsStream,
        builder: (context, snapshot){
            print(chat.chats.length);
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: chat.chats.length,
              itemBuilder: (BuildContext context,int index){
                return Text(chat.chats[index]);
            },
          );
          }
          if(!snapshot.hasData){
            return Text("as");
          }
        },
      ),
    );
  }

  Widget _buildSender(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: TextField(
              controller: _senderController,

            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            flex:1,
            child: RaisedButton(
              onPressed: (){
                chat.sendMessage(_senderController.text);
                _senderController.clear();
              },
              child: Text("Send"),
            ),
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Group Chat"),
      ),
      body: Container(
        child: BlocBuilder<GroupChatBloc,GroupChatState>(
          bloc:  BlocProvider.of<GroupChatBloc>(context),
          builder: (BuildContext context,GroupChatState state){
            if(state is InitialGroupChatState){
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
              chat = state.chatResources;
              return Column(
                children: <Widget>[
                  _buildGroupChat(),
                  _buildSender(),
                ],
              );
            }
             return CircularProgressIndicator();
          },),
      )
    );
  }

  @override
  void initState() { 
    BlocProvider.of<GroupChatBloc>(context).dispatch(LoadGroupChatEvent(room: "test"));
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    
  }

  @override
  void dispose() {
    chat.disconnect();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    switch(state){
      case AppLifecycleState.resumed:
      setState(() {
        BlocProvider.of<GroupChatBloc>(context).dispatch(LoadGroupChatEvent(room: "test"));
      });
      break;
      case AppLifecycleState.inactive:
      chat.disconnect();
      break;
      case AppLifecycleState.paused:
      break;
      case AppLifecycleState.suspending:
      chat.disconnect();
      break;
    }
  }


}