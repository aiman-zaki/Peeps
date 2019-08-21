import 'package:flutter/material.dart';

class StashView extends StatefulWidget {
  final String room;
  StashView({Key key,this.room}) : super(key: key);

  _StashViewState createState() => _StashViewState();
}

class _StashViewState extends State<StashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Stash"),
      ),
      body: Container(
        
      ),
    );
  }
}