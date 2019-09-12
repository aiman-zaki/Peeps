import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/inbox.dart';
import 'package:peeps/screens/splash_page.dart';

import 'groupwork/groupwork_profile.dart';


class InboxInvitationView extends StatefulWidget {
  InboxInvitationView({Key key}) : super(key: key);

  _InboxInvitationViewState createState() => _InboxInvitationViewState();
}

class _InboxInvitationViewState extends State<InboxInvitationView> {
  InboxBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<InboxBloc>(context);
    bloc.dispatch(LoadInboxEvent());
    super.initState();
  }

  Widget _buildGroupInvitationListView(List<GroupInvitationMailModel> data){
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          onTap: (){
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => GroupworkProfile(data:data[index].group))
            );
          },
          leading: Text(data[index].inviterEmail),
          trailing: RaisedButton(
            onPressed: (){
              setState(() {
                bloc.dispatch(ReplyInvitationEvent(reply: true,groupId: data[index].groupInviteId));
              });
            },
            child: new Text('Accept'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Invitation"),
      ),
      body: BlocBuilder<InboxBloc,InboxState>(
              bloc: bloc,
              builder: (BuildContext context, InboxState state){
                if(state is InitialInboxState){
                    return SplashScreen();
                }
                if(state is LoadingInboxState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is LoadedInboxState){
                  return _buildGroupInvitationListView(state.data);
                }
                if(state is NoInvitationState){
                  return Center(
                    child: Container(
                      child: Text("No Invitation"),
                    ),
                  );
                }

          
              },
      ),
    );
  }
}