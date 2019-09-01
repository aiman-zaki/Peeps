import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/kanban_board_bloc.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/common.dart';
import 'package:peeps/screens/common/circular_fab.dart';
import 'package:peeps/screens/groupwork/task_form.dart';
import 'package:peeps/screens/splash_page.dart';
import 'board.dart';

//TODO editmode
enum Mode {
  normal,
  edit,
}
class KanbanBoardView extends StatefulWidget {
  final List<TaskModel> todo;
  final List<TaskModel> doing;
  final List<TaskModel> done;
  KanbanBoardView({Key key, this.todo, this.doing, this.done}) : super(key: key);

  _KanbanBoardViewState createState() => _KanbanBoardViewState();
}

class _KanbanBoardViewState extends State<KanbanBoardView> {
  @override
  void initState() {
    super.initState();
  }
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
        child: Board(todo: widget.todo,doing: widget.doing,done: widget.done,)
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskForm(),
            )
          );
        },
      ),
    );
  }
}

