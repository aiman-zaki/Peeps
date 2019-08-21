import 'package:flutter/material.dart';
import 'package:peeps/models/groupwork.dart';

class GroupworkProfile extends StatefulWidget {
  final GroupworkModel data;
  

  GroupworkProfile({Key key,@required this.data}) : super(key: key);

  _GroupworkProfileState createState() => _GroupworkProfileState();
}

class _GroupworkProfileState extends State<GroupworkProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Groupwork Profile"),
      ),
    );
  }
}