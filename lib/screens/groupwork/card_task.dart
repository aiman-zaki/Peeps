import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/groupwork/detail_task.dart';
import 'package:peeps/screens/groupwork/task_form.dart';


class CardTask extends StatelessWidget {

  final TaskModel task;

  const CardTask({Key key,this.task}) : super(key: key);

  Color _cardColorSwitch(int priority){
    switch(priority){
      case(1):
        return Colors.red[800];
      case(2):
        return Colors.amber;
      case(3):
        return Colors.yellow[700];
      default:
        return Colors.grey[700];
    }
  }



  @override
  Widget build(BuildContext context) {
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    Color _color = _cardColorSwitch(task.priority);


    void _showDialog(BuildContext context,TaskModel task,Color _headerColor){
      showDialog(
        context: (context),
        builder: (BuildContext context) => BlocProvider.value(
          value: _taskBloc,
          child: DialogTaskCard(task: task,headerColor:_headerColor),
        )
      );
    }

    return GestureDetector(
        onTap: (){
          _showDialog(context,task,_color);
        },
        child: Card(
          margin: EdgeInsets.all(2),
          elevation: 3,
          color: _color,
          child: Padding(
            padding:  EdgeInsets.all(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(task.task,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text('${task.assignTo.split("@")[0]}',style: 
                  TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic
                  ),),
                )
              ],
            ),
          ),
        ),
    );
  }
}

class DialogTaskCard extends StatelessWidget {
  final TaskModel task;
  final Color headerColor;

  const DialogTaskCard({Key key,this.task,this.headerColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deleteTextController = TextEditingController();
    final _key = new GlobalKey<FormState>();
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    Widget _buildBody(){
      return Padding(
        padding: EdgeInsets.all(9),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Description : ',
                    style: TextStyle(
                      color: Colors.cyan
                    ),),
                Text(task.description),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Text('Creator : ',
                    style: TextStyle(
                      color: Colors.cyan
                    ),),
                Text(task.creator),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Text('Assign To : ',
                    style: TextStyle(
                      color: Colors.cyan
                    ),),
                Text(task.assignTo),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Text('Due Date : ',
                    style: TextStyle(
                      color: Colors.cyan
                    ),),
                Text(task.dueDate.toString()),
              ],
            ),
            SizedBox(height: 20,)
            
          ],
        ),
      );
    }

    _showConfirmationDialog(String title){
      showDialog(
        context: context,
        builder: (context){
          return DialogWithAvatar(
            width: 400,
            height: 200,
            avatarIcon: Icon(Icons.warning),
            title: 'Delete $title?',
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _key,
                  child: TextFormField(
                    validator: (v){
                      if(v.isEmpty){
                        return 'Please Enter Task Title';
                      }if(_deleteTextController.text != title){
                        return 'Not Same';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                    ),
                    controller: _deleteTextController,
                  ),
                ),
              )
            ],
            bottomLeft: FlatButton(
              child: Text('Cancel'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            bottomRight: FlatButton(
              child: Text('Delete'),
              onPressed: (){
                if(_key.currentState.validate()){
                  _taskBloc.dispatch(DeleteTaskButtonClickedEvent(taskId: task.id));
                }
              },
            ),
          );
        }
      );
    }

    Widget _buildHeader(){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
        decoration: BoxDecoration(
          color: headerColor,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          )
        ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
                _showConfirmationDialog(task.task);
              },
              child: Icon(Icons.delete)),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(task.task),
          ),
          Align(
            alignment: FractionalOffset.centerRight,
            child: InkWell(
              child: Icon(Icons.edit),
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailTaskView(),
                    fullscreenDialog: true
                  )
                );
              },
            ),
          )
        ],
      ),
      );
    }

    return Center(
      child: Container(
        height: 300,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            padding: EdgeInsets.only(bottom: 9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: <Widget>[
                _buildHeader(),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



