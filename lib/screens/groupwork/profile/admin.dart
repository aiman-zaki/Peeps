import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/bloc/user/bloc.dart';
import 'package:peeps/models/groupwork.dart';

import 'package:peeps/screens/common/common_profile_picture.dart';

class GroupProfileAdmin extends StatefulWidget {

  final GroupworkModel groupData;
  
  GroupProfileAdmin({
    Key key,
    @required this.groupData}) : super(key: key);

  _GroupProfileAdminState createState() => _GroupProfileAdminState();
}

class _GroupProfileAdminState extends State<GroupProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<GroupProfileBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);

    _buildDeleteButton({@required email}){
      return BlocBuilder<ProfileBloc,ProfileState>(
        builder: (context,state){
          if(state is ProfileLoaded){
            if(state.data.email == email)
              return Container();
            else{
              return RaisedButton(
                color: Colors.red[800],
                onPressed: (){
                  Map<String,dynamic> data = {
                    "email":email,
                    "groupId":widget.groupData.id
                  };
                  _bloc.add(DeleteMemberEvent(data: data));
                },
                child: Text("Remove"),
              );
            }
          }
        },
      );
    }


    _buildAssignAdminButton({@required int role,@required String email}){
      if(role != 0){
        Map<String,dynamic> data = {
          "email":email,
          "role":0,
          "groupId":widget.groupData.id,
        };
        return RaisedButton(
          onPressed: (){
            _bloc.add(UpdateAdminRoleEvent(data: data));
          },
          child: Text("Promote as Admin"),
        );
      }
      return Container();
    }



    _buildRoleIcon({@required int role}){
      IconData icon;
      if(role == 0){
        icon = FontAwesomeIcons.crown;
      }
      if(role == 1){
        icon = FontAwesomeIcons.user;
      }
      return  Positioned(
        top: 0,
        child: Icon(icon),
      );
    }


    _buildMembersList(data){
      return GridView.builder(
        itemCount: data.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        ),
        itemBuilder: (context,index){
          return Container(
            padding: EdgeInsets.all(9),
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
               
                    CustomNetworkProfilePicture(
                      bottomRadius: 0,
                      topRadius: 0,
                      heigth: 100,
                      image: data[index].profilePicture,
                    ),
                    _buildRoleIcon(role:data[index].role),
                  ],
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(data[index].email,style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
                 _buildAssignAdminButton(role: data[index].role,email: data[index].email),
                 _buildDeleteButton(email: data[index].email),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Team"),
      ),
      body: Container(
        child: BlocBuilder<MembersBloc,MembersState>(
          builder: (context,state){
            if(state is LoadingMembersState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedMembersState){
              return _buildMembersList(state.data);
            }
          },
        )
      ),
    );
  }
}