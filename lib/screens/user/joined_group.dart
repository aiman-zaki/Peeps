import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/user_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/router/navigator_args.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/groupwork/groupwork_form.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/groupwork_hub.dart';
import 'package:peeps/screens/splash_page.dart';


class GroupworksView extends StatefulWidget {
  final UserModel user;
  GroupworksView({Key key,this.user}) : super(key: key);

  _GroupworksViewState createState() => _GroupworksViewState();
}

class _GroupworksViewState extends State<GroupworksView> {
  final _repository = GroupworkRepository();
  GroupworkBloc _bloc;
  ProfileBloc _profileBloc;

  @override
  void initState(){
    _bloc = BlocProvider.of<GroupworkBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    Widget _buildAvatar(GroupworkModel groupwork){
      return Container(
        child: CustomNetworkProfilePicture(
          bottomRadius: 0,
          topRadius: 10,
          heigth: 100,
          image: groupwork.profilePicturerUrl,
          child: Center(child: Text(groupwork.name),),
        ),
      );
    }

    Widget _groupCard(GroupworkModel groupwork){
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          child: Column(
            children: <Widget>[
              _buildAvatar(groupwork),
              Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text('Pinned Notes')),
                        Expanded(
                          flex: 1,
                          child: Icon(Icons.info_outline)),
                      ],
                    ),
                    SizedBox(height: 10,),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupwork.notes.isEmpty ? 0 : groupwork.notes.length,
                      itemBuilder: (context,index){
                        if(groupwork.notes.isEmpty){
                          return Text("No Pinned Notes");
                        } else {
                          return Text(groupwork.notes[index].note);
                        }

                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    Widget _buildGroupworkList(List<GroupworkModel> data){
      return GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              Map<String,dynamic> arg = {
                "userData":widget.user,
                "groupData":data[index],
              };
              final NavigatorArguments _navArgs = NavigatorArguments(data: arg);
              Navigator.of(context).pushNamed('group',arguments: _navArgs);
              
            },
            child: _groupCard(data[index]),
            
          );
        },
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Groupwork"),
      ),
      body: BlocBuilder<GroupworkBloc,GroupworkState>(
        bloc: _bloc,
        builder: (BuildContext context, GroupworkState state){
          if(state is InitialGroupworkState){
            _bloc.dispatch(LoadGroupworkEvent(data: widget.user.activeGroup));
            return SplashScreen();
          }
          if(state is LoadingGroupworkState){
            return Center(child: CircularProgressIndicator());
          }
          if(state is LoadedGroupworkState){    
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                   _bloc.dispatch(LoadGroupworkEvent(data: widget.user.activeGroup));
                },
                child: _buildGroupworkList(state.data)),
            );
          }
          if(state is NoGroupworkState){
            return Container(
              child: Center(
                child: Text("No Groupwork Joined"),
              ),
            );
          }

        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            Navigator.of(context).push(
              CupertinoPageRoute<GroupworkForm>(
                builder: (context) {
                  return BlocProvider<GroupworkBloc>.value(
                    value: GroupworkBloc(repository: _repository, usersRepository: const UserRepository()),
                    child: GroupworkForm(),
                  );
                }
              )
            );
          });
        },
      ),
    );
  }
}