import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/screens/groupwork/groupwork_form.dart';
import 'package:peeps/screens/groupwork/groupwork_hub.dart';
import 'package:peeps/screens/splash_page.dart';

import 'groupwork/groupwork_bottombar.dart';

class GroupworksView extends StatefulWidget {
  GroupworksView({Key key}) : super(key: key);

  _GroupworksViewState createState() => _GroupworksViewState();
}

class _GroupworksViewState extends State<GroupworksView> {
  UserModel user;
  final _repository = GroupworkRepository();
  GroupworkBloc _bloc;
  ProfileBloc _profileBloc;


  Widget _groupCard(GroupworkModel group){
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 14.0,
            right: 14.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(tag: group.id, child: Text(group.name,style: TextStyle(),),)
                ],
              ),
              Divider(color: Colors.blueAccent,),
              Text('Quick Access')
            ],
          ),
        ),
      ),
    );


  }
  Widget _buildGroupworkList(List<GroupworkModel> data){
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => GroupworkHub(groupData:data[index],userData: user,))
            );
          },
          child: _groupCard(data[index]),
          
        );
      },
    );
  }

  @override
  void initState(){
    _bloc = BlocProvider.of<GroupworkBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    //TODO : 
    _profileBloc.state.listen((state){
      if(state is ProfileLoaded){
        this.user = state.data;
        _bloc.dispatch(LoadGroupworkEvent(data: this.user.activeGroup));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GroupWork"),
        actions: <Widget>[
          InkWell(
            onTap: (){
              _profileBloc.dispatch(LoadProfile());
            },
            child: Icon(Icons.refresh),
          )
        ],
      ),
      body: BlocBuilder<GroupworkBloc,GroupworkState>(
        bloc: _bloc,
        builder: (BuildContext context, GroupworkState state){
          if(state is InitialGroupworkState){
            return SplashScreen();
          }
          if(state is LoadingGroupworkState){
            return Center(child: CircularProgressIndicator());
          }
          if(state is LoadedGroupworkState){    
            return _buildGroupworkList(state.data);
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
                    value: GroupworkBloc(repository: _repository),
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