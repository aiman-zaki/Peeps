import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/inbox.dart';
import 'package:peeps/screens/splash_page.dart';

import 'groupwork/groupwork_profile.dart';

class InboxInvitationView extends StatefulWidget {
  InboxInvitationView({Key key}) : super(key: key);

  _InboxInvitationViewState createState() => _InboxInvitationViewState();
}

class _InboxInvitationViewState extends State<InboxInvitationView> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<InboxBloc>(context)
      ..dispatch(LoadInboxEvent());

    Widget _captions({@required text}) {
      return Text(
        "$text",
        style: TextStyle(color: Colors.white30),
      );
    }

    Widget _buildItem(GroupInvitationMailModel data) {
      return Container(
        child: ExpandablePanel(
            hasIcon: false,
            header: Card(
              color: Colors.blueGrey[900],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.group.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 6,
                              child: Text(
                                data.inviterEmail,
                                style: TextStyle(fontSize: 14),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(DateFormat()
                                  .add_yMMMd()
                                  .format(new DateTime.now()))),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 50,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              child: Icon(FontAwesomeIcons.trash),
                              alignment: Alignment.bottomLeft,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: RaisedButton(
                              elevation: 8.00,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.all(12),
                              color: Colors.green[800],
                              onPressed: () {
                                setState(() {
                                  bloc.dispatch(ReplyInvitationEvent(
                                      reply: true, groupId: data.groupInviteId));
                                });
                              },
                              child: Text("Accept"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            expanded: Card(
              color: Colors.blueGrey[800],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _captions(text: "Description"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.group.description,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _captions(text: "Creator"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.group.creator,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _captions(text: "Course"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.group.course,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
            )),
      );
    }

    Widget _buildGroupInvitationListView(List<GroupInvitationMailModel> data) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(data[index]);

          ListTile(
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) =>
                      GroupworkProfile(data: data[index].group)));
            },
            leading: Text(data[index].inviterEmail),
            trailing: RaisedButton(
              onPressed: () {
                setState(() {
                  bloc.dispatch(ReplyInvitationEvent(
                      reply: true, groupId: data[index].groupInviteId));
                });
              },
              child: new Text('Accept'),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<InboxBloc, InboxState>(
          bloc: bloc,
          builder: (BuildContext context, InboxState state) {
            if (state is InitialInboxState) {
              return SplashScreen();
            }
            if (state is LoadingInboxState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadedInboxState) {
              return Column(
                children: <Widget>[
                  Text(
                    "Groupwork Invitation",
                    style: TextStyle(fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: _buildGroupInvitationListView(state.data),
                  ),
                ],
              );
            }
            if (state is NoInvitationState) {
              return Center(
                child: Container(
                  child: Text("No Invitation"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
