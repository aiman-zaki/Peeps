import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/enum/status_enum.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/screens/common/custom_milestone.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HubMilestoneView extends StatefulWidget {
  HubMilestoneView({Key key}) : super(key: key);

  @override
  _HubMilestoneViewState createState() => _HubMilestoneViewState();
}

class _HubMilestoneViewState extends State<HubMilestoneView> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final _assignmentBloc = BlocProvider.of<AssignmentBloc>(context);

    double _calculateCompletedPercentage(List<AssignmentModel> assignments){
      int assignmentsDone = 0;
      for(AssignmentModel assignment in assignments){
        if(assignment.status == Status.done){
          assignmentsDone = assignmentsDone+1;
        }
      }
      return assignmentsDone/assignments.length;
    } 

    return BlocBuilder(
      bloc: _assignmentBloc,
      builder: (context,state){
        if(state is InitialAssignmentsState || state is UpdatedAssignmentStatusState){
          return Container();
        }
        if(state is LoadingAssignmentState || state is UpdatingAssignmentStatusState ){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is LoadedAssignmentState){
          return Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Milestone',
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: LinearPercentIndicator(
                      leading: Text('0%'),
                      center: Text('50%'),
                      trailing: Text('100%'),
                      animateFromLastPercent: true,
                      animation: true,
                      percent:  _calculateCompletedPercentage(state.data),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                      lineHeight:  14.00,
                    
                    )
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}