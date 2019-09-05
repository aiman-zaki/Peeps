import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
//TODO : Dynamic Role Assignation - Madam Faridah
class AssignmentForm extends StatelessWidget {
  final String groupId;

  const AssignmentForm({Key key,this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _assignmentBloc = BlocProvider.of<AssignmentBloc>(context);
    final _titleController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _leaderController = TextEditingController();
    final _totalMarks = TextEditingController();

    _buildDialog(){
      showDialog(
        context: (context),
        builder: (context){
          return DialogWithAvatar(
            avatarIcon: Icon(Icons.check),
            title: "Confirm",
            description: "Add new Assignment?",
            width: 400,
            height: 180,
            children: <Widget>[
              SizedBox(height: 15,),
            ],
            bottomLeft: FlatButton(
              child: Text("Cancel"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            bottomRight: FlatButton(
              child: Text('Confirm'),
              onPressed: (){
                _assignmentBloc.dispatch(AddAssignmentEvent(
                  assignment:AssignmentModel(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    leader: _leaderController.text,
                    totalMarks: 0.01              
                  ), groupId: groupId
                  ));
                Navigator.of(context).pop();
              },
            ),
          );
        }
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Assignment Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(controller:_titleController,decoration: InputDecoration(labelText:  "Title"),),
              TextFormField(controller:_descriptionController,decoration: InputDecoration(labelText:  "Description"),),
              TextFormField(controller:_leaderController,decoration: InputDecoration(labelText:  "Leader"),),
              TextFormField(controller:_totalMarks,decoration: InputDecoration(labelText:  "Total Marks"),),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _buildDialog();
        },
      )
    );
  }
}