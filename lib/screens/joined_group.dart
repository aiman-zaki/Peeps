import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/screens/groupwork_form.dart';
import 'package:peeps/screens/splash_page.dart';

import 'group_detail.dart';

class GroupworksView extends StatefulWidget {
  GroupworksView({Key key}) : super(key: key);

  _GroupworksViewState createState() => _GroupworksViewState();
}

class _GroupworksViewState extends State<GroupworksView> {

  final _repository = GroupworkRepository();
  GroupworkBloc _bloc;
  ProfileBloc _profileBloc;

  Widget _buildGroupworkList(List<GroupworkModel> data){
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => GroupworkDetailView(data:data[index]))
            );
          },
          child: Container(
            child: Card(

              child: Column(
                children: <Widget>[
                  Text(data[index].name)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState(){
    _bloc = BlocProvider.of<GroupworkBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    //TODO : 
    ProfileLoaded state = _profileBloc.currentState;
    if(state is ProfileLoaded){
      print(state.data);
    }
    _bloc.dispatch(LoadGroupworkEvent(data: state.data.activeGroup));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GroupWork"),
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