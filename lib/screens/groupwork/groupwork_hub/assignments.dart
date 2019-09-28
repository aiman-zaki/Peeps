import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/screens/groupwork/kanban/kanban.dart';

import '../assignment_form.dart';

class HubAssignments extends StatefulWidget {
  final groupData;
  final userData;
  HubAssignments({
    Key key,
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
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    final size = MediaQuery.of(context).size;

    _buildLeaderTag(String leader){
      if(leader == widget.userData.email) 
        return Card(
          elevation: 5.00,
          color:Colors.pink, 
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("Leader"),
          ));
      else
        return Text(""); 
    }
    _buildAssignmentList(List<AssignmentModel> data) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          if (data.isNotEmpty) {
            return Card(
              color: Color.fromARGB(30, 0, 188, 212),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                    tapBodyToCollapse: true,
                    header: Container(
                      width: size.width,
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
                    collapsed: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) =>
                                  BlocProvider<TaskBloc>.value(
                                value: _taskBloc,
                                child: KanbanBoardView(
                                  data: data[index],
                                  groupId: widget.groupData.id,
                                ),
                              ),
                            ));
                          },
                          leading: Icon(Icons.developer_board),
                          title: Text("Kanban Board"),
                        ),
                      ],
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
          } else {
            return Container(
              width: size.width,
              child: Text("No Assignments"),
            );
          }
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(),
            child: Row(
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
                            _assignmentBloc.dispatch(LoadAssignmentEvent(
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
                                child: AssignmentFormView(
                                  groupId: widget.groupData.id,
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
          ),
          BlocBuilder<AssignmentBloc, AssignmentState>(
            builder: (BuildContext context, AssignmentState state) {
              if (state is InitialAssignmentState) {
                _assignmentBloc.dispatch(
                    LoadAssignmentEvent(groupId: widget.groupData.id));
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
    );
  }
}
