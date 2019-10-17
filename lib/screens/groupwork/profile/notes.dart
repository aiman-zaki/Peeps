import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';

import 'notes_form.dart';

class GroupProfileNotes extends StatefulWidget {
  final groupId;

  GroupProfileNotes({
    Key key,
    @required this.groupId
    }) : super(key: key);

  _GroupProfileNotesState createState() => _GroupProfileNotesState();
}

class _GroupProfileNotesState extends State<GroupProfileNotes> {

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<NoteBloc>(context);

    _buildNotesList(notes){
      return Container(
        child: Column(
          children: <Widget>[
            
          ],
        ),
      );
    }

    return Scaffold(
       appBar: AppBar(
         title: Text("Notes | Announcements"),
       ),
      body: BlocBuilder<NoteBloc,NoteState>(
        builder: (context,state){
          if(state is InitialNoteState){
            _bloc.add(LoadNotesEvent(data: {
              "groupId":widget.groupId,
            }));
            return Container();
          } 
          if(state is LoadingNotesState){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is LoadedNotesState){
            return _buildNotesList(state.data);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: _bloc,
                child: NoteForm(groupId:widget.groupId),
              ),
              fullscreenDialog: true
            ),
          );
        },
      ),
    );
  }
}