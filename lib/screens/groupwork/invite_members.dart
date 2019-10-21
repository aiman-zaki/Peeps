import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/common/custom_search.dart';

class InviteMembersView extends StatefulWidget {

  final groupData;
  
  InviteMembersView({Key key,
    @required this.groupData
  }) : super(key: key);

  _InviteMembersViewState createState() => _InviteMembersViewState();
}

class _InviteMembersViewState extends State<InviteMembersView> {
 
@override
Widget build(BuildContext context) {


  final _bloc = BlocProvider.of<InviteMembersBloc>(context);
  List datas = [];

  List _dataFromState(){
    var currentState = _bloc.state;
    if(currentState is LoadedUsersState){
        return currentState.data;
    } else {
      return [];
    }
  }

  datas = _dataFromState();

  _buildInvitationButton(user){
    List filter = widget.groupData.invitations.where((invite)
      => invite == user.email
    ).toList();
    if(filter.isEmpty){
      return FlatButton(
          onPressed: (){
            Map<String,dynamic> data = {
              "email":user.email,
              "groupId":widget.groupData.id
            };
            _bloc.add(InviteMemberEvent(data: data));
          },
          child: Text("Invite"));
    }
    else {
      return FlatButton(
        onPressed: null,
        child: Text("Invited"),
      );
    }
  }
  
  Widget _listViewChild(user){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: CustomNetworkProfilePicture(
            width: 60,
            image: user.profilePicture,
          ),
          trailing: _buildInvitationButton(user),
          title: Text(user.email),
        ),
      ),
    );
  }

  _searchInput(String searchIn){
    _bloc.add(SearchButtonClickedEvent(data: searchIn));    
  }

  _showLoadingDialog(){
    showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          children: <Widget>[
            Center(child: CircularProgressIndicator(),),
          ],
        );
      }
    );
  }

  return Scaffold(
    appBar: AppBar(
      title: Text("Invite Members"),
    ),
    backgroundColor: Theme.of(context).backgroundColor,
    body: BlocListener(
      bloc: _bloc,
      listener: (context,state){
        if(state is LoadingUsersState)
          _showLoadingDialog();
        if(state is LoadedUsersState){
            Navigator.pop(context);
            setState(() {
              
            });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomSearch(
            searchInput: _searchInput,
            data: datas,
            listViewChild: _listViewChild,
            textInputLabel: "Email/Name",
          ),
        ),
      ),
    );
  }
}