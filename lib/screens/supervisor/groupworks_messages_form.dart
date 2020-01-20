import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/bulletin.dart';


class GroupworksMessageForm extends StatefulWidget {
  GroupworksMessageForm({Key key}) : super(key: key);

  @override
  _GroupworksMessageFormState createState() => _GroupworksMessageFormState();
}

class _GroupworksMessageFormState extends State<GroupworksMessageForm> {
  @override
  Widget build(BuildContext context) {
    final _supervisormessagebloc = BlocProvider.of<SupervisorMessagesBloc>(context);
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Form"),),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(controller: titleController,),
            TextFormField(controller: bodyController,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _supervisormessagebloc.add(CreateSupervisorMessagesEvent(data: BulletinModel(
            body: bodyController.text, createdDate: DateTime.now(), email: null, id: null, title: titleController.text, updatedDate: DateTime.now(),
          )));
        },
      )
    );
  }
}