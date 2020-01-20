import 'package:flutter/material.dart';
import 'package:peeps/screens/groupwork/assignment/timeline_user.dart';

import 'timeline.dart';


class TimelineBaseView extends StatefulWidget {
  TimelineBaseView({Key key}) : super(key: key);

  @override
  _TimelineBaseViewState createState() => _TimelineBaseViewState();
}

class _TimelineBaseViewState extends State<TimelineBaseView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text("Timelines"),),
              Tab(child: Text("User Only "),)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AssignmentTimelineView(),
            TimelineUserView()
          ],
        ),
      ),
    );
  }
}