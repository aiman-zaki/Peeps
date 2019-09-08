import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';

import '../../routing_constant.dart';

class GroupworkForm extends StatefulWidget {
  GroupworkForm({Key key}) : super(key: key);
  _GroupworkFormState createState() => _GroupworkFormState();
}

class _GroupworkFormState extends State<GroupworkForm> {
  var _bloc;
  final  _key = new GlobalKey<FormState>();
  final _nameController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _courseController = new TextEditingController();
  List<TextEditingController> _membersController = [];

  _showConfirmationDialog(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return DialogWithAvatar(
          width: 400,
          height: 180,
          avatarIcon: Icon(Icons.check),
          title: "Confirm",
          description: "Do you realy want to create the groupwork?",
          bottomLeft: FlatButton(
            child: Text("Cancel"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          bottomRight: FlatButton(
            child: Text("Confirm"),
            onPressed: (){
                _submitButton();
                Navigator.of(context).popUntil(ModalRoute.withName(HomeViewRoute));
            },
          ),
        );
      }
    );
  }

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
        labelText: "Member : "+index.toString()
      ),
    );
  }

  Widget _buildOptionalCard(){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Optional"),
          Row(children: <Widget>[
            Text("Invite Members"),
            InkWell(
              child: Icon(Icons.add),
              onTap: (){
                setState(() {
                  _membersController.add(new TextEditingController());
                });
              },
            ),
            InkWell(
              child: Icon(Icons.remove),
              onTap: (){
                setState(() {
                  if(_membersController.isNotEmpty){
                    _membersController.removeLast();
                  }
                });
              },
            )
          ],),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: _membersController.length,
            itemBuilder: (BuildContext context,int index){
              return _buildInviteMembers(index);
            },
          )
        ],
      ),
    );
  }

  Widget _buildMandatoryCard(){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
   
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Groupwork Information'),
            TextFormField(
              validator: (v){
                if(v.isEmpty){
                  return "Enter The Groupwork Name";
                }
                return null;
              },
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
            Divider(),
        ],
      ),
    );
  }


  Widget _buildForm(){
    return Container(
      child: Form(
        key: _key,
        child: ListView(
          children: <Widget>[
            _buildMandatoryCard(),
            _buildOptionalCard(),
          ],
        ),
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
          padding: EdgeInsets.all(9),
          child: _buildForm(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_right),
          onPressed: (){
           if(_key.currentState.validate()){
              _showConfirmationDialog();
           }
        },
      ),
    );
    
  }
}