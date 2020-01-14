import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/assignment_task_requests/assignment_task_requests_bloc.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/models/request.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/splash_page.dart';


class TaskRequestsView extends StatefulWidget {
  TaskRequestsView({Key key}) : super(key: key);

  @override
  _TaskRequestsViewState createState() => _TaskRequestsViewState();
}

class _TaskRequestsViewState extends State<TaskRequestsView> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final _dueDate = TextEditingController();
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
                      Expanded(
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text("Approve"),
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context){
                                data[index].approval = Approval.approved;
                                return DialogWithAvatar(
                                  avatarIcon: Icon(Icons.check),
                                  height: 150,
                                  children: <Widget>[
                                    DateTimeField(
                                      decoration: InputDecoration(
                                        labelText: "Due Date"
                                      ),
                                      controller: _dueDate,
                                      format: format,
                                      onShowPicker: (context, currentValue) async {
                                        final date = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            initialDate: currentValue ?? DateTime.now(),
                                            lastDate: DateTime(2100));
                                        if (date != null) {
                                          final time = await showTimePicker(
                                            context: context,
                                            initialTime:
                                                TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                          );
                                          return DateTimeField.combine(date, time);
                                        } else {
                                          return currentValue;
                                        }
                                      },
                                    ),
                                  ],
                                  bottomRight: FlatButton(
                                    onPressed: (){
                                       data[index].dueDate = DateTime.parse(_dueDate.text);
                                      _bloc.add(UpdateTaskRequestEvent(data: data[index]));
                                    },
                                    child: Text("Confirm"),
                                  ),
                                );
                              }
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.red,
                          child: Text("Deny"),
                          onPressed: (){
                            data[index].approval = Approval.deny;
                            _bloc.add(UpdateTaskRequestEvent(data: data[index]));
                          },
                        ),
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