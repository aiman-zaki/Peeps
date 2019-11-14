import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/screens/groupwork/collaborate/forum.dart';
import 'package:peeps/screens/groupwork/collaborate/groupworks.dart';
import 'package:peeps/screens/groupwork/collaborate/map.dart';

import 'user_joined.dart';


class CollaborateBottomBarView extends StatefulWidget {

  final userData;
  final course;

  CollaborateBottomBarView({
    Key key,
    @required this.userData,
    @required this.course,
    }) : super(key: key);

  _CollaborateBottomBarViewState createState() => _CollaborateBottomBarViewState();
}

class _CollaborateBottomBarViewState extends State<CollaborateBottomBarView> {

  var _userJoinedView;
  var _forumView;
  var _map;
  var _groupworks;
  Widget _showPage;

  pageChooser(int index){
    switch(index){
      case(0):
        return _forumView;
      case(1):
        return _userJoinedView;
      case(2):
        return _map;
      case(3):
        return _groupworks;
      default:
        return new Container(
          child: Center(child: Text("Not a valid Path"),),
        );
    }
  }

  @override
  void initState() {
    BlocProvider.of<CollaborateBloc>(context).add(InitialCollaborateEvent(userData: widget.userData));
    BlocProvider.of<CollaborateForumBloc>(context).add(LoadForumEvent());
    BlocProvider.of<CollaborateMapBloc>(context).add(ReadMapMarkerEvent());
    BlocProvider.of<CollaborateGroupworkBloc>(context).add(ReadCollaborateGroupworksEvent(data: widget.course));
    _forumView = new CollaborateForumView(course: widget.course);
    _userJoinedView = new UserJoinedCollaborateView();
    _map = new CollaborateMapView();
    _groupworks = new CollaborateGroupworksView();
    _showPage = _forumView;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.black,
        buttonBackgroundColor: Colors.black,
        items: <Widget>[
          Icon(FontAwesomeIcons.solidObjectGroup),
          Icon(FontAwesomeIcons.forumbee),
          Icon(Icons.local_airport),
          Icon(Icons.group_work)
        ],
        onTap: (index){
          setState(() {
            _showPage = pageChooser(index);
          });
        },
      ),
      body: _showPage,
    );
  }
}