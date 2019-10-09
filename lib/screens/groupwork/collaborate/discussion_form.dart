import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/discussion.dart';

class DiscussionFormView extends StatefulWidget {

  DiscussionFormView({Key key}) : super(key: key);
  
  _DiscussionFormViewState createState() => _DiscussionFormViewState();
}

class _DiscussionFormViewState extends State<DiscussionFormView> {

 
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
     final _bloc = BlocProvider.of<CollaborateForumBloc>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Discussion Form"),
      ),
      body: Container(
        padding: EdgeInsets.all(9),
         child: Form(
           child: Column(
             children: <Widget>[
               TextFormField(
                 controller: _titleController,

               ),
               TextFormField(
                 controller: _descriptionController,
               ),
             ],
           ),
         ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          _bloc.dispatch(CreateNewDiscussionEvent(data: DiscussionModel(
            id: "0",
            title: _titleController.text,
            description: _descriptionController.text,
            replies: [],
          )));
        },
      ),
    );
  }
}