import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peeps/bloc/user/bloc.dart';
import 'package:peeps/screens/splash_page.dart';

class AssignmentsCountdown extends StatefulWidget {
  AssignmentsCountdown({Key key}) : super(key: key);

  _AssignmentsCountdownState createState() => _AssignmentsCountdownState();
}

class _AssignmentsCountdownState extends State<AssignmentsCountdown> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<AssignmentsBloc>(context);
    final size = MediaQuery.of(context).size;

    _buildAssignmentsCountdown(data) {
      return Container(
        height: 200,
        padding: EdgeInsets.all(3.0),
        child: Card(
          elevation: 8.00,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                child: ClipPath(
                    clipper: WaveClipperTwo(reverse: true),
                    child: Container(
                      width: size.width/2,
                      height: 70,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Colors.redAccent,
                        Colors.redAccent[400],
                        Colors.redAccent[700],
                      ])),
                    ))),
              Padding(
                padding: EdgeInsets.all(9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Reminder",
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(
                      thickness: 2.0,
                      height: 15,
                      color: Colors.pink[100],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        if (data[index]['assignments'].isNotEmpty) {
                          var assignments = data[index]['assignments'];
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: assignments.length,
                            itemBuilder: (context, index2) {
                              var countdown = assignments[index2]
                                  .dueDate
                                  .difference(DateTime.now())
                                  .inDays;
                              if (countdown > 0) {
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 3,
                                        child: Text(assignments[index2].title)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                            "days : ${countdown.toString()}")),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<AssignmentsBloc, AssignmentsState>(
      builder: (context, state) {
        if (state is InitialAssignmentsState) {
          _bloc.add(LoadUserAssignmentsEvent());
          return Container();
        }
        if (state is LoadingUserAssignmentsState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedUserAssignmentsState) {
          return _buildAssignmentsCountdown(state.data);
        }
      },
    );
  }
}
