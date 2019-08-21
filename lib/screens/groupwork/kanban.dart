import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/kanban_board_bloc.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/common.dart';
import 'package:peeps/screens/splash_page.dart';
import 'board.dart';

//TODO editmode
enum Mode {
  normal,
  edit,
}


class KanbanBoardView extends StatefulWidget {
  KanbanBoardView({Key key}) : super(key: key);

  _KanbanBoardViewState createState() => _KanbanBoardViewState();
}

class _KanbanBoardViewState extends State<KanbanBoardView> {
  KanbanBoardBloc bloc;

  List<TaskModel> todo = [TaskModel(id: '1',creator: 'syafira@gmail.com',assignTo: 'aiman@gmail.com,',description: '1Play Rimworld',createdDate: null,assignDate: null,dueDate: null, task: "Finish ERD", priority: 1),
  TaskModel(id: '4',creator: 'syafira@gmail.com',assignTo: 'aiman@gmail.com,',description: '1Play Rimworld',createdDate: null,assignDate: null,dueDate: null, task: "Finish ERD", priority: 2),
  TaskModel(id: '5',creator: 'syafira@gmail.com',assignTo: 'aiman@gmail.com,',description: '1Play Rimworld',createdDate: null,assignDate: null,dueDate: null, task: "Finish ERD", priority: 3),
  TaskModel(id: '6',creator: 'syafira@gmail.com',assignTo: 'aiman@gmail.com,',description: '1Play Rimworld',createdDate: null,assignDate: null,dueDate: null, task: "Finish ERD", priority: 4),
  TaskModel(id: '7',creator: 'syafira@gmail.com',assignTo: 'aiman@gmail.com,',description: '1Play Rimworld',createdDate: null,assignDate: null,dueDate: null, task: "Finish ERD", priority: 5),
  TaskModel(id: '8',creator: 'syafira@gmail.com',assignTo: 'aiman@gmail.com,',description: '1Play Rimworld',createdDate: null,assignDate: null,dueDate: null, task: "Finish ERD")] ;
 
  List<TaskModel> doing = [TaskModel(id: '2',creator: 'syafira@gmail.com',assignTo: 'aiman@gmail.com,',description: '2Play Rimworld',createdDate: null,assignDate: null,dueDate: null,task: "SV interview")] ;
  List<TaskModel> done = [TaskModel(id: '3',creator: 'syafira@gmail.com',assignTo: 'aiman@gmail.com,',description: '3Play Rimworld',createdDate: null,assignDate: null,dueDate: null,task: "Submit")] ;


  List<Widget> _buildActions(){
    return [
      InkWell(
          onTap: (){

          },
          child: Icon(Icons.refresh),
      ),
      SizedBox(width: 20,),
      InkWell(
        child: Icon(Icons.save),
        onTap: (){
          print("test");
          setState(() {
      
          });
        }, 
      ),
      SizedBox(width: 20,),
    ];
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kanban Board"),
        actions: _buildActions(),
      ),
      body: Container(
        child: BlocBuilder<KanbanBoardBloc,KanbanBoardState>(
          bloc: bloc,
          builder: (BuildContext context,KanbanBoardState state){
            if(state is InitialKanbanBoardState){
              return SplashScreen();
            }
            if(state is LoadingKanbanBoardState){
              return LoadingIndicator();
            }
            if(state is LoadedKanbanBoardState){
              return Board(todo: todo,doing: doing,done: done,);
            }
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    bloc = BlocProvider.of<KanbanBoardBloc>(context);
    bloc.dispatch(LoadKanbanBoardEvent());
    super.initState();
  }
}

