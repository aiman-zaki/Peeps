import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'inbox_invitation.dart';

class InboxBottomBarView extends StatefulWidget {
  InboxBottomBarView({Key key}) : super(key: key);

  _InboxBottomBarViewState createState() => _InboxBottomBarViewState();
}

class _InboxBottomBarViewState extends State<InboxBottomBarView> {

  final _inboxInvitationView = new InboxInvitationView();
  Widget _showPage = new InboxInvitationView();

  Widget _pageChoose(int index){
    switch(index){
      case(0):
        return _inboxInvitationView;
        break;
      case(1):
      //return _inboxMessageView;
        break;
      default:
        return new Container(
          child: Center(child: Text("Not a valid Path"),),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.black,
        buttonBackgroundColor: Colors.black,
        items: <Widget>[
          Icon(Icons.message, size:30),
          Icon(Icons.inbox, size:30),
        ],
        onTap: (index){
          setState(() {
            _showPage = _pageChoose(index);

          });
        },
      ),
      body: Container(
        child: _showPage,
      ),
    );
  }
}