import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/member.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/groupwork/chat/group_chat.dart';

import '../invite_members.dart';

class HubMembers extends StatefulWidget {
  final groupData;
  final userData;
  HubMembers({
    Key key,
    @required this.groupData,
    @required this.userData,
    }) : super(key: key);

  _HubMembersState createState() => _HubMembersState();
}

class _HubMembersState extends State<HubMembers> {
  @override
  Widget build(BuildContext context) {

    final _membersBloc = BlocProvider.of<MembersBloc>(context);
    final _groupChatBloc = BlocProvider.of<GroupChatBloc>(context);
    final _inviteMembersBloc = BlocProvider.of<InviteMembersBloc>(context);

    _buildMembersList(List<MemberModel> data) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: <Widget>[
                IconSlideAction(
                  icon: Icons.message,
                  color: Colors.blue,
                  caption: 'Chat',
                  onTap: (){

                  },
                )
              ],
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      child: CustomNetworkProfilePicture(
                        width: 120,
                        heigth: 120,
                        image: data[index].profilePicture,
                      ),
                    ),
                    title: Text(data[index].email),
                   
                  ),
                ),
              ),
            );
          });
    }
    return Container(
       child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Members',
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
              Expanded(
                flex: 1,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<InviteMembersBloc>.value(
                                  value: _inviteMembersBloc,
                                  child: InviteMembersView(groupData: widget.groupData,)),
                          fullscreenDialog: true),
                    );
                  },
                  child: Text(
                    'Invite',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<MembersBloc, MembersState>(
            bloc: _membersBloc,
            builder: (context, state) {
              if (state is InitialMembersState) {
                _membersBloc
                    .dispatch(LoadMembersEvent(groupId: widget.groupData.id));
                return Container();
              }
              if (state is LoadingMembersState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is LoadedMembersState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildMembersList(state.data),
                );
              }
              return Container();
            },
          ),
          SizedBox(
              width: double.maxFinite,
              child: FlatButton(
                child: Text("Group Chat"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      child: GroupChatView(
                        room: widget.groupData.id,
                        user: widget.userData,
                      ),
                      value: _groupChatBloc,
                    ),
                  ));
                },
              ))
        ],
      ),
    );
  }
}