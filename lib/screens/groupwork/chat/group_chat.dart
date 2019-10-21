import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';

import 'package:peeps/models/message.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/chat.dart';

class GroupChatView extends StatefulWidget {
  final String room;
  final UserModel user;

  GroupChatView({Key key,@required this.room,@required this.user}) : super(key: key);

  _GroupChatViewState createState() => _GroupChatViewState();
}

class _GroupChatViewState extends State<GroupChatView> with WidgetsBindingObserver {
  ChatResources chat;
  final _senderController = TextEditingController();

  Widget _buildSenderText(ChatModel senderMessage){
    return Padding(
      padding: EdgeInsets.only(bottom: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Container(),
          ),
          Flexible(
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: <Widget>[
                    Text(senderMessage.message),
                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildGroupsText(ChatModel participantMessage){
    return Padding(
      padding: EdgeInsets.only(bottom: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
      
        children: <Widget>[
          
          Flexible(
            child: Card(
              color: Colors.blueAccent,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
       
                  children: <Widget>[
              
                    Text(participantMessage.message)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget _buildGroupChat(){
    return Expanded(
      flex: 4,
      child: StreamBuilder(
        stream: chat.chatsStream,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: chat.chats.length,
              itemBuilder: (BuildContext context,int index){
                if(chat.chats[index].senderEmail == widget.user.email){
                  return _buildSenderText(chat.chats[index]);
                } else {
                  return _buildGroupsText(chat.chats[index]);
                }
            },
          );
          }
          if(!snapshot.hasData){
            return Text("No Conversation");
          }
        },
      ),
    );
  }

  Widget _buildSender(){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: TextField(
                style: TextStyle(
                  fontSize: 13.0,
                  height: 1.0
                ),
                decoration: InputDecoration(
                  hintText: "Message",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2)
                  )
                ),
                controller: _senderController,

              ),
            ),
            SizedBox(
              width: 2.0,
            ),
            Expanded(
              flex:1,
              child: GestureDetector(
                onTap: (){
                  chat.sendMessage(ChatModel(
                    message: _senderController.text, 
                    senderEmail: widget.user.email, 
                    date: new DateTime.now(), 
                    room: widget.room));
                  _senderController.clear();
                },
                child: Icon(Icons.send),
              )
              ),
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        title: Text("Group Chat"),
      ),
      body: Container(
        width: double.infinity,
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
              //chat.receiveMessage();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
   
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    
  }

  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    switch(state){
      case AppLifecycleState.resumed:
      setState(() {
        BlocProvider.of<GroupChatBloc>(context).add(LoadGroupChatEvent(room: widget.room));
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