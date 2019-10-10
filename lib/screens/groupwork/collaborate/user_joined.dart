import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/message.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';

class UserJoinedCollaborateView extends StatefulWidget {

  UserJoinedCollaborateView({Key key}) : super(key: key);

  _UserJoinedCollaborateViewState createState() => _UserJoinedCollaborateViewState();
}

class _UserJoinedCollaborateViewState extends State<UserJoinedCollaborateView> {

  @override
  Widget build(BuildContext context) {

    final _bloc = BlocProvider.of<CollaborateBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: BlocBuilder<ProfileBloc,ProfileState>(
        builder:  (context,profileState){
          if(profileState is ProfileLoaded){
            return BlocBuilder(
              bloc: _bloc,
              builder: (context,state){
                if(state is InitialCollaborateState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is InitializingCollaborateState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is InitializedCollaborateState){
   
                  return StreamBuilder(
                    stream: state.resource.usersStream,
                    builder: (context,snapshot){

                      var users = state.resource.users;
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context,index){
                          return Card(
                            child: Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  icon: Icons.people,
                                  caption: 'Profile',
                                  color: Colors.green,
                                ),
                                IconSlideAction(
                                  icon: Icons.message,
                                  caption: 'Message',
                                  color: Colors.blue,
                                )
                              ],
                              child: Padding(
                                padding: EdgeInsets.all(9.0),
                                child: ListTile(
                                  leading: CustomNetworkProfilePicture(
                                    image: users[index].picture,
                                    width: 60,
                                  ),
                                  title: Text(users[index].email),
                    
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}