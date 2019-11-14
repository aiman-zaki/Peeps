import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/screens/groupwork/stash/stash.dart';

class PublicGroupworkProfileView extends StatefulWidget {
  final GroupworkModel data;
  
  PublicGroupworkProfileView({
    Key key,
    @required this.data
    
  }) : super(key: key);

  @override
  _PublicGroupworkProfileViewState createState() => _PublicGroupworkProfileViewState();
}

class _PublicGroupworkProfileViewState extends State<PublicGroupworkProfileView> {
  @override
  Widget build(BuildContext context) {
    final _referencesBloc  = BlocProvider.of<ReferenceBloc>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text("Groupwork Profile"),
        ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              
            ],
          ),
        ),
      ),
    );
  }
}