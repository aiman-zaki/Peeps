import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/changed_status.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/groupwork/task_form.dart';
import 'board.dart';

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
  List<TaskModel> _todo = [];
  List<TaskModel> _doing = [];
  List<TaskModel> _done = [];
  final _taskBloc = BlocProvider.of<TaskBloc>(context);
  final _membersBloc = BlocProvider.of<MembersBloc>(context);
  final _timelineBloc = BlocProvider.of<TimelineBloc>(context);

  _separate(data){  
    for(TaskModel task in data){
      if(task.status == 0){
        _todo.add(task);
      }
      if(task.status == 1){
        _doing.add(task);
      }
      if(task.status == 2){
        _done.add(task);
    
      }
    }
    
  }
  List<Widget> _buildActions(){
    return [
      InkWell(
          onTap: (){
            _todo = [];
            _doing = [];
            _done = [];
            _taskBloc.add(LoadTaskEvent());
          },
          child: Icon(Icons.refresh),
      ),
      SizedBox(width: 20,),
      InkWell(
        child: Icon(Icons.save),
        onTap: (){
       
          _taskBloc.add(UpdateTaskStatus(tasks: changedStatus, assignmentId: widget.data.id));
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
            _taskBloc.add(DeleteTaskEvent(assignmentId: widget.data.id,taskId: state.taskId));
          }
          if(state is DisplayMessageSnackbar){
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              )
            );
          }
        },
        child: BlocBuilder<TaskBloc,TaskState>(
          builder: (context,state){
            if(state is InitialTaskState){
              _todo = [];
              _doing = [];
              _done = [];
              _taskBloc.add(LoadTaskEvent());
              return Container();
            }
            if(state is LoadingTaskState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedTaskState){
              _separate(state.data);
              return Container(
                child: Board(todo: _todo,doing: _doing, done: _done,callback: callBack,)
                  );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: _taskBloc,
                child: BlocProvider.value(
                  value: _membersBloc,
                  child: BlocProvider.value(
                    value: _timelineBloc,
                    child: TaskForm(edit:false,groupId: widget.groupId,assignmentId: widget.data.id,)))),
              fullscreenDialog: true,
            )
          );
        },
      ),
    );
  }
}

