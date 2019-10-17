import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/user/task/bloc.dart';
import 'package:peeps/screens/user/countdown.dart';
import 'package:peeps/screens/user/user_task.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  
  @override
  Widget build(BuildContext context) {
 
    return RefreshIndicator(
      onRefresh: () async{
        BlocProvider.of<UserTaskBloc>(context).add(LoadUserTaskEvent());
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: AssignmentsCountdown()),
                Expanded(
                  flex: 2,
                  child: Container(),
                )
              ],
            ),
            UserTasks(),
          ],
        ),
      ),
    );
  }
}