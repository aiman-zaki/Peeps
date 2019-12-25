import 'package:flutter/material.dart';


class GroupChatForm extends StatefulWidget {
  GroupChatForm({Key key}) : super(key: key);

  __GroupChatFormState createState() => __GroupChatFormState();
}

class __GroupChatFormState extends State<GroupChatForm> {
  final _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Message"
            ),
          )
        ],
      )
    );
  }
}