import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/screens/splash_page.dart';


class InboxInvitationView extends StatefulWidget {
  InboxInvitationView({Key key}) : super(key: key);

  _InboxInvitationViewState createState() => _InboxInvitationViewState();
}

class _InboxInvitationViewState extends State<InboxInvitationView> {
  InboxBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<InboxBloc>(context);
    bloc.dispatch(LoadInboxEvent(query:"inbox.group_invitation"));
    super.initState();
  }

  Widget _buildGroupInvitationListView(Map<String,dynamic> data){
    List groupInvitationList = data['inbox']['group_invitation'];
    return ListView.builder(
      itemCount: groupInvitationList.length,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          leading: Text(groupInvitationList[index]['group_id']['\$oid']),
          trailing: RaisedButton(
            onPressed: (){
              setState(() {
                bloc.dispatch(ReplyInvitationEvent(reply: "accept",groupId: groupInvitationList[index]['group_id']['\$oid']));
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
        title: Text("Inbox"),
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

          
              },
      ),
    );
  }
}