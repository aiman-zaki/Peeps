import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/groupwork.dart';

import 'package:peeps/screens/common/withAvatar_dialog.dart';



class GroupworkForm extends StatefulWidget {
  GroupworkForm({Key key}) : super(key: key);
  _GroupworkFormState createState() => _GroupworkFormState();
}

class _GroupworkFormState extends State<GroupworkForm> {

  final  _key = new GlobalKey<FormState>();
  final _nameController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _courseController = new TextEditingController();
  final _templateController = TextEditingController();
  List<TextEditingController> _membersController = [];

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final _bloc = BlocProvider.of<GroupworkBloc>(context);

  Widget _captions({@required text}){
    return Text(
        "$text",
        style: TextStyle(
          color: Colors.white30
        ),
      );
  }

  _submitButton(){
    List<String> membersEmail = [];
    for(var member in _membersController){
      membersEmail.add(member.text);
    }

    _bloc.add(CreateNewGroupworkEvent(data: GroupworkModel(
      id: "",
      name: _nameController.text,
      course: _courseController.text,
      invitations: membersEmail,
      creator: "",
      description: _descriptionController.text,
      members: [],
      templateId: _templateController.text == "" ? null : _templateController.text,
      complaints: [],
    )));
    
    Navigator.of(context).pop();
    

  }

    _showConfirmationDialog(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return DialogWithAvatar(
          width: 400,
          height: 180,
          avatarIcon: Icon(Icons.check),
          title: Text("Confirm"),
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
                Navigator.of(context).pop();
                
            },
          ),
        );
      }
    );
  }
  Widget _buildInviteMembers(int index){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: (){
          setState(() {
            if(_membersController.isNotEmpty){
              _membersController.removeAt(index);
            }
          });
        },
        trailing: Icon(Icons.remove_circle_outline),
        title: TextFormField(
          controller: _membersController[index],
          decoration: InputDecoration(
            labelText: "Email"
          ),
        ),

      ),
    );

  }

  Widget _buildOptionalCard(){
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Optional",style:TextStyle(
            fontSize: 20,
          ),),
          SizedBox(height: 10,),
          _captions(text: "Insert Template ID for this Groupwork"),
          TextFormField(
            controller: _templateController,
            decoration: InputDecoration(
              labelText: 'Template ID'
            ),
          ),
          Divider(),
          _captions(text: "Invite your team members, can be invited later"),
          
          ListTile(
            title: Text("Invite Members"),
            leading: Icon(Icons.person_outline),
            trailing: InkWell(
              child: Icon(Icons.add_circle_outline),
              onTap: (){
                setState(() {
                  _membersController.add(new TextEditingController());
                });
              },
            ),
          ),
          
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
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Mandatory Information",style: TextStyle(fontSize: 20),),
          SizedBox(height: 10,),
          _captions(text: "Condsider a proper name to be displayed Globally"),
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
          SizedBox(height: 10,),
          _captions(text: "Briefly Describe your Groupwork for public"),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description'
            ),
          ),
          SizedBox(height: 10,),
          _captions(text: "Enter valid courses Available based on your University"),
          TextFormField(
            controller: _courseController,
            decoration: InputDecoration(
              labelText: 'Course'
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  return Scaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    appBar: AppBar(
        title: Text("Groupwork Form"),  
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              Container(),
              Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  _buildMandatoryCard(),
                  SizedBox(height: 10,),
                  _buildOptionalCard(),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.check),
        onPressed: (){
          if(_key.currentState.validate()){
            _showConfirmationDialog();
          }
        },
      ),
    );
    
  }
}