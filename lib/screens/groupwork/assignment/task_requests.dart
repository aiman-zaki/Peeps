import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/assignment_task_requests/assignment_task_requests_bloc.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/models/request.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/splash_page.dart';


class TaskRequestsView extends StatefulWidget {
  TaskRequestsView({Key key}) : super(key: key);

  @override
  _TaskRequestsViewState createState() => _TaskRequestsViewState();
}

class _TaskRequestsViewState extends State<TaskRequestsView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<AssignmentTaskRequestsBloc>(context);

    _buildTaskRequestState(List<TaskRequestModel> data){
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          if(data[index].approval == Approval.tbd){
            return Card(
              child: Container(
                padding: EdgeInsets.all(9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${data[index].requester}'),
                    Text('Reasons : ${data[index].message}'),
                    Text('Task: ${data[index].task.task}'),
                    Row(
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green,
                        child: Text("Approve"),
                        onPressed: (){
                          data[index].approval = Approval.approved;
                          _bloc.add(UpdateTaskRequestEvent(data: data[index]));
                        },
                      ),
                      SizedBox(width: 10,),
                      RaisedButton(
                        color: Colors.red,
                        child: Text("Deny"),
                        onPressed: (){
                          data[index].approval = Approval.deny;
                          _bloc.add(UpdateTaskRequestEvent(data: data[index]));
                        },
                      )
                    ],
                  ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitoring"),  
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context,state){
          if(state is InitialAssignmentTaskRequestsState){
            return SplashScreen();
          }
          if(state is LoadingAssignmentTaskRequestsState){
            return Center(child: CircularProgressIndicator(),);
          } 
          if(state is LoadedAssingmentTaskRequestsState){
            return _buildTaskRequestState(state.data);
          }
        },
      )
    );
  }
}