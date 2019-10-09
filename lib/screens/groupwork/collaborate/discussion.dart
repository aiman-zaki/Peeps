import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';

class DiscussionView extends StatefulWidget {
  DiscussionView({Key key}) : super(key: key);

  _DiscussionViewState createState() => _DiscussionViewState();
}

class _DiscussionViewState extends State<DiscussionView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CollaborateDiscussionBloc>(context);
    _bloc.dispatch(LoadDiscussionEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("Discussion"),
      ),
      body: Container(

      ),
    );
  }
}