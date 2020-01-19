import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/discussion.dart';
import 'package:peeps/screens/common/captions.dart';

class DiscussionFormView extends StatefulWidget {
  final bool isAdmin;
  DiscussionFormView({Key key,@required this.isAdmin}) : super(key: key);
  
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
        padding: EdgeInsets.all(16),
         child: Form(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               CustomCaptions(text: "Make it short",),
               TextFormField(
                 decoration: InputDecoration(
                   labelText: "Discussion"
                 ),
                 controller: _titleController,

               ),
               SizedBox(height: 20,),
               CustomCaptions(text: "Detail Description of your title",),
               TextFormField(
                 minLines: 3,
                 maxLines: 6,
                 controller: _descriptionController,
               ),
             ],
           ),
         ),
      ),
      floatingActionButton: !widget.isAdmin?
        FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: (){
            _bloc.add(CreateNewDiscussionEvent(data: DiscussionModel(
              id: "0",
              title: _titleController.text,
              description: _descriptionController.text,
              replies: [], by: "",
              createdDate: DateTime.now(),
            )));
          },
        ) : null
    );
  }
}