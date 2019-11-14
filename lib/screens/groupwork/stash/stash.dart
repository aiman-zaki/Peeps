import 'package:flutter/material.dart';
import 'package:peeps/screens/groupwork/stash/references.dart';


class StashView extends StatefulWidget {
  StashView({Key key}) : super(key: key);

  _StashViewState createState() => _StashViewState();
}

class _StashViewState extends State<StashView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stash"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text("References"),),
              Tab(child: Text("Items"),)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ReferencesView(isPublic: false,),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}