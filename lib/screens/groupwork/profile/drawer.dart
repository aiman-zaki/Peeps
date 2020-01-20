import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/note_repository.dart';
import 'package:peeps/screens/groupwork/profile/notes.dart';
import 'package:peeps/screens/groupwork/profile/requests.dart';

import 'admin.dart';

class GroupworkProfileDrawerView extends StatefulWidget {
  final data;
  GroupworkProfileDrawerView({Key key, @required this.data}) : super(key: key);

  @override
  _GroupworkProfileDrawerViewState createState() => _GroupworkProfileDrawerViewState();
}

class _GroupworkProfileDrawerViewState extends State<GroupworkProfileDrawerView> {

  
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<GroupProfileBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);

    _buildDrawerContent() {
        return Container(
          padding: EdgeInsets.all(9),
          child: ListView(
            children: <Widget>[
              ListTile(
            
                leading: Icon(FontAwesomeIcons.criticalRole),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: _bloc,
                      child: BlocProvider.value(
                          value: _membersBloc,
                          child: GroupProfileAdmin(
                            groupData: widget.data,
                          )),
                    ),
                  ));
                },
                title: Text("Team"),
              ),
              
              ListTile(
                title: Text("Requests"),
   
                leading: Icon(FontAwesomeIcons.inbox),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => RequestBloc(
                                groupworkRepository:
                                    GroupworkRepository(data: widget.data.id)),
                            child: GroupRequest(
                              groupId: widget.data.id,
                            ),
                          )));
                },
              ),
              ListTile(
                title: Text("Update"),
   
                leading: Icon(FontAwesomeIcons.arrowUp),
                onTap: () {
                  _bloc.add(UpdateTemplateRevision());
                },
              )
            ],
          ),
        );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Text("Admin's Features"),
            ),),
          Expanded(child: _buildDrawerContent(),)
        ],
      ),
    );
  }
}