import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/groupwork.dart';




class GroupworkForm extends StatefulWidget {
  GroupworkForm({Key key}) : super(key: key);
  _GroupworkFormState createState() => _GroupworkFormState();
}

class _GroupworkFormState extends State<GroupworkForm> {
  var _bloc;
  final GlobalKey _key = new GlobalKey();
  final _nameController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _courseController = new TextEditingController();
  List<TextEditingController> _membersController = [];

  _submitButton(){
    List<String> membersEmail = [];
    for(var member in _membersController){
      membersEmail.add(member.text);
    }
    BlocProvider.of<GroupworkBloc>(context).dispatch(NewGroupButtonPressedEvent(name: _nameController.text,
    description: _descriptionController.text,course: _courseController.text,members: membersEmail));

    }

  Widget _buildInviteMembers(int index){
    return TextFormField(
      controller: _membersController[index],
      decoration: InputDecoration(
        labelText: "Members"+index.toString()
      ),
    );
  }
  Widget _buildForm(){
    return Form(
      key: _key,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name'
            ),
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description'
            ),
          ),
          TextFormField(
            controller: _courseController,
            decoration: InputDecoration(
              labelText: 'Course'
            ),
          ),
          Row(children: <Widget>[
            Text("Invite Members"),
            RaisedButton(
              child: Text("Add"),
              onPressed: (){
                setState(() {
                  _membersController.add(new TextEditingController());
                });
              },
            )
          ],),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _membersController.length,
            itemBuilder: (BuildContext context,int index){
              return _buildInviteMembers(index);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Create"),  
        ),
        body: Container(
          child: _buildForm(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_right),
          onPressed: (){
            _submitButton();
        },
      ),
    );
    
  }
}