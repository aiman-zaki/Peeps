import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/changed_status.dart';
import 'package:peeps/screens/groupwork/task_form.dart';
import 'board.dart';

//TODO editmode
enum Mode {
  normal,
  edit,
}
class KanbanBoardView extends StatefulWidget {
  final String groupId;
  final AssignmentModel data;
  KanbanBoardView({Key key,this.data,this.groupId}) : super(key: key);

  _KanbanBoardViewState createState() => _KanbanBoardViewState();
}

class _KanbanBoardViewState extends State<KanbanBoardView> {
  List<ChangedStatus> changedStatus = [];

  callBack(newChangedStatus){

    setState(() {
      changedStatus = newChangedStatus;
    });
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  final _taskBloc = BlocProvider.of<TaskBloc>(context);
  List<Widget> _buildActions(){
    return [
      InkWell(
          onTap: (){
            _taskBloc.dispatch(RefreshAssignmentEvent(assignmentId: widget.data.id,groupId: widget.groupId));
          },
          child: Icon(Icons.refresh),
      ),
      SizedBox(width: 20,),
      InkWell(
        child: Icon(Icons.save),
        onTap: (){
          _taskBloc.dispatch(UpdateTaskStatus(tasks: changedStatus, assignmentId: widget.data.id));
        }, 
      ),
      SizedBox(width: 20,),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Kanban Board"),
        actions: _buildActions(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocListener(
        bloc: _taskBloc,
        listener: (context,state){
          if(state is DeletingTaskState){
            _taskBloc.dispatch(DeleteTaskEvent(assignmentId: widget.data.id,taskId: state.taskId));
          }
          if(state is DisplayMessageSnackbar){
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              )
            );
          }
        },
        child: Container(
          child: Board(todo: widget.data.todo,doing: widget.data.ongoing,done: widget.data.done,callback: callBack,)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: _taskBloc,
                child: TaskForm(groupId: widget.groupId,assignmentId: widget.data.id,)),
              fullscreenDialog: true,
            )
          );
        },
      ),
    );
  }
}

