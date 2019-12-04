import 'package:flutter/material.dart';
import 'package:peeps/models/template.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';

class TasksTemplateFormView extends StatefulWidget {
  final bool isEdit;
  final List<TaskTemplateModel> tasks;
  TasksTemplateFormView({Key key,@required this.isEdit,  this.tasks}) : super(key: key);

  @override
  _TasksTemplateFormViewState createState() => _TasksTemplateFormViewState();
}

class _TasksTemplateFormViewState extends State<TasksTemplateFormView> {
  List<TaskTemplateModel> tasks = [];
  final _titleController =  TextEditingController();
  final _descriptionController = TextEditingController();
  final _difficultyController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    if(widget.isEdit){
      tasks =  widget.tasks;
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    _showTaskTemplateForm(){
      showDialog(
        context: context,
        builder: (context){
          return DialogWithAvatar(
            height: 350,
            avatarIcon: Icon(Icons.check),
            title: Text("Task"),
            description: "",
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title"
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Description"
                ),
              ),
              TextFormField(
                controller: _difficultyController,
                decoration: InputDecoration(
                  labelText: "Difficulty"
                ),
              )
            ],
            bottomRight: FlatButton(
              child: Text("Confirm"),
              onPressed: (){
                tasks.add(
                  TaskTemplateModel(
                    id: "",
                    title: _titleController.text,
                    description: _descriptionController.text,
                    difficulty: int.parse(_difficultyController.text)
                  )
              

                );
                Navigator.of(context).pop();
              },
            ),
          );
        }
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop(tasks);
          },
        ),
        title: Text("Tasks Template Form"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(child: Text("Tasks")),
              Expanded(
                child: FlatButton(
                  onPressed: (){
                    _showTaskTemplateForm();
                  },
                  child: Text("Add"),),
              )
            ],),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      title: Text(tasks[index].title),
                      subtitle: Text(tasks[index].description),
                      trailing: Text(tasks[index].difficulty.toString()),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.of(context).pop(tasks);
        },
      ),
    );
  }
}