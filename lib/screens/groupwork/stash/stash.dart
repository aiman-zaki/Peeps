import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/screens/groupwork/stash/references.dart';

import 'submitted_material.dart';


class StashView extends StatefulWidget {
  final bool isPublic;
  StashView({
    Key key,
    @required this.isPublic
  }):super(key:key);

  _StashViewState createState() => _StashViewState();
}

class _StashViewState extends State<StashView> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Stash"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text("References"),),
              Tab(child: Text("Submited Materials"),)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ReferencesView(isPublic: widget.isPublic,),
            SubmittedMaterialView(scaffoldKey: _scaffoldKey,)
          ],
        ),
      ),
    );
  }
}