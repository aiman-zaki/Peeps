import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/user/task/bloc.dart';
import 'package:peeps/screens/user/countdown.dart';
import 'package:peeps/screens/user/user_task.dart';
import 'package:showcaseview/showcase_widget.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<State<StatefulWidget>> _assignmentsCountdown = GlobalKey(debugLabel: '_assignmentsCountdown');
  final GlobalKey<State<StatefulWidget>> _userTasks = GlobalKey(debugLabel: '_UserTasksState');

  
  @override
  void initState() {
    super.initState();     
    //WidgetsBinding.instance.addPostFrameCallback((_)=>
      //ShowCaseWidget.of(context).startShowCase([_assignmentsCountdown,_userTasks])); 
  }

  
  @override
  Widget build(BuildContext context) {
 
    return RefreshIndicator(
      onRefresh: () async{
        BlocProvider.of<UserTaskBloc>(context).add(LoadUserTaskEvent());
        BlocProvider.of<AssignmentsBloc>(context).add(LoadUserAssignmentsEvent());
      },
      child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: AssignmentsCountdown(showCaseKey:{"assignmentsCountdown":_assignmentsCountdown})),
                  
                  ],
                ),
                UserTasks(showCaseKey: {'userTasks':_userTasks},),
              ],
            ),
          )
    );
  }
}