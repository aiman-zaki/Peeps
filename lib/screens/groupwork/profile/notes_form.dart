import 'package:flutter/material.dart';
import 'package:peeps/screens/common/captions.dart';

class NoteForm extends StatefulWidget {
  final groupId;
  NoteForm({Key key, this.groupId}) : super(key: key);

  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomCaptions(text: "Make it short",),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                    labelText: "Note",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
