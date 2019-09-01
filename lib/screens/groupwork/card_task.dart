import 'package:flutter/material.dart';
import 'package:peeps/models/task.dart';


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

  void _showDialog(BuildContext context,TaskModel task,Color _headerColor){
    showDialog(
      context: (context),
      builder: (BuildContext context){
        return DialogTaskCard(task: task,headerColor:_headerColor);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Color _color = _cardColorSwitch(task.priority);
    return GestureDetector(
        onLongPress: (){
          _showDialog(context,task,_color);
        },
        child: Card(
          margin: EdgeInsets.all(2),
          elevation: 3,
          color: _color,
          child: Column(
            children: <Widget>[
              Text(task.task,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                ),
              ),
              Text(task.assignTo,style: 
                TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic
                ),),
            ],
          ),
        ),
    );
  }
}

class DialogTaskCard extends StatelessWidget {
  final TaskModel task;
  final Color headerColor;
  const DialogTaskCard({Key key,this.task,this.headerColor}) : super(key: key);


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
          )
        ],
      ),
    );
  }


  Widget _buildHeader(){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20,bottom: 20),
      decoration: BoxDecoration(
        color: headerColor,
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        )
      ),
    child: Text(task.task),
    );
  }

  @override
  Widget build(BuildContext context) {
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



