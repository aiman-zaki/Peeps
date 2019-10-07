import 'package:flutter/material.dart';

import 'package:peeps/screens/home/user_task.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  
  @override
  Widget build(BuildContext context) {
 
    return Column(
      children: <Widget>[
        UserTasks(),
      ],
    );
  }
}