import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/models/reply.dart';

class ReplyFormView extends StatefulWidget {

  final callback;
  
  ReplyFormView({Key key,this.callback}) : super(key: key);

  _ReplyFormViewState createState() => _ReplyFormViewState();
}

class _ReplyFormViewState extends State<ReplyFormView> {
  final _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CollaborateDiscussionBloc>(context);
    widget.callback(_replyController.text);
    
    return Container(
      height: 160,
      padding: EdgeInsets.all(9),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              minLines: 5,
              maxLines: 6,
              controller: _replyController,
            )
          ],
        ),
      ),
    );
  }
}
