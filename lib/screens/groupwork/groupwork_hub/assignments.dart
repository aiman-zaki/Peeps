import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/resources/assignment_repository.dart';

import 'package:peeps/resources/task_repository.dart';
import 'package:peeps/screens/groupwork/kanban/kanban.dart';
import 'package:peeps/screens/groupwork/review/peer_review.dart';

import '../assignment_form.dart';

class HubAssignments extends StatefulWidget {
  final isAdmin;
  final groupData;
  final userData;
  HubAssignments({
    Key key,
    @required this.isAdmin,
    @required this.groupData,
    @required this.userData,
  }) : super(key: key);

  _HubAssignmentsState createState() => _HubAssignmentsState();
}

class _HubAssignmentsState extends State<HubAssignments> {
  @override
  Widget build(BuildContext context) {
    final _assignmentBloc = BlocProvider.of<AssignmentBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);
    final _timelineBloc = BlocProvider.of<TimelineBloc>(context);
    final size = MediaQuery.of(context).size;

    _buildLeaderTag(String leader) {
      if (leader == widget.userData.email)
        return Card(
            elevation: 5.00,
            color: Colors.pink,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("Leader"),
            ));
      else
        return Text("");
    }

    _buildAssignmentList(List<AssignmentModel> data) {
      if (data.isNotEmpty) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actions: <Widget>[
                  widget.isAdmin
                      ? IconSlideAction(
                          color: Colors.red,
                          icon: Icons.delete,
                          caption: "Delete",
                          onTap: () {
                            _assignmentBloc.add(
                                DeleteAssignmentEvent(data: data[index].id));
                                setState(() {
                                  data.removeAt(index);
                                });
                          },
                        )
                      : Container(),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    color: Colors.blue,
                    icon: Icons.developer_board,
                    caption: "KanbanBoard",
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => BlocProvider<TaskBloc>(
                          builder: (context) => TaskBloc(
                              repository: TaskRepository(data: data[index].id), timelineBloc: _timelineBloc),
                          child: BlocProvider<MembersBloc>.value(
                            value: _membersBloc,
                            child: BlocProvider<TimelineBloc>.value(
                              value: _timelineBloc,
                              child: KanbanBoardView(
                                data: data[index],
                                groupId: widget.groupData.id,
                              ),
                            ),
                          ),
                        ),
                      ));
                    },
                  ),
                  IconSlideAction(
                    color: Colors.indigo,
                    icon: Icons.perm_device_information,
                    caption: "Peers Review",
                    onTap: (){
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => 
                        MultiBlocProvider(
                          providers: [
                            BlocProvider<PeerReviewBloc>(
                              builder: (context) => PeerReviewBloc(repository: AssignmentRepository(data: data[index].id))
                              ..add(LoadPeerReviewEvent()),
                           
                            ),
                            BlocProvider<MembersBloc>.value(
                              value: _membersBloc,
                            )
                          ],
                          child: PeersReviewView(assignment: data[index],)),
                      ));
                    },
                  )
                ],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandablePanel(
                      hasIcon: false,
                      tapBodyToCollapse: true,
                      header: Container(
                        width: size.width,
                        padding: EdgeInsets.all(9),
                        child: Stack(
                          children: <Widget>[
                            Text(
                              data[index].title,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: _buildLeaderTag(data[index].leader),
                            )
                          ],
                        ),
                      ),
                      expanded: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.dashboard),
                            title: Text("Description"),
                            subtitle: Text(data[index].description),
                          ),
                          ListTile(
                            leading: Icon(Icons.people),
                            title: Text("Leader"),
                            subtitle: Text(data[index].leader),
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text("Due Date"),
                            subtitle: Text(data[index].dueDate.toString()),
                          ),
                        ],
                      )),
                ),
              );
            });
      }
      return Container(
        padding: EdgeInsets.all(9),
        height: 50,
        child: Text("No Assignments"),
      );
    }

    return Card(
      elevation: 8.00,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Assignments',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.lightBlue[400], fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            _assignmentBloc.add(LoadAssignmentEvent(
                                groupId: widget.groupData.id));
                          },
                          child: Icon(Icons.refresh)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value: _assignmentBloc,
                              child: BlocProvider.value(
                                value: _membersBloc,
                                child: BlocProvider.value(
                                  value: _timelineBloc,
                                  child: AssignmentFormView(
                                    userData: widget.userData,
                                    groupId: widget.groupData.id,
                                  ),
                                ),
                              )),
                          fullscreenDialog: true,
                        ));
                      },
                      child: Text(
                        "New",
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
            BlocBuilder<AssignmentBloc, AssignmentState>(
              builder: (BuildContext context, AssignmentState state) {
                if (state is InitialAssignmentState) {
                  _assignmentBloc
                      .add(LoadAssignmentEvent(groupId: widget.groupData.id));
                  return Container();
                }
                if (state is LoadingAssignmentState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is LoadedAssignmentState) {
                  return _buildAssignmentList(state.data);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
