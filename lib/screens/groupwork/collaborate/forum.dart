import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/collaborate_forum/collaborate_forum_bloc.dart';
import 'package:peeps/resources/discussion_repository.dart';
import 'package:peeps/screens/groupwork/collaborate/discussion.dart';
import 'package:peeps/screens/groupwork/collaborate/discussion_form.dart';

class CollaborateForumView extends StatefulWidget {

  final course;
  CollaborateForumView({Key key,this.course}) : super(key: key);

  _CollaborateForumViewState createState() => _CollaborateForumViewState();
}

class _CollaborateForumViewState extends State<CollaborateForumView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CollaborateForumBloc>(context);
    
    _buildDiscussionsList(data){
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return Card(
            child: ListTile(
              title: Text(data[index].title),
              subtitle: Text(data[index].by),
              onTap: (){
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => BlocProvider(
                      builder: (context) => CollaborateDiscussionBloc(repository: DiscussionRepository(data: widget.course,data2: data[index].id)),
                      child: DiscussionView(),
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }


    return Scaffold(
       appBar: AppBar(
         title: Text("Forum"),
       ),
       body: RefreshIndicator(
         onRefresh: ()  async {
           _bloc.dispatch(LoadForumEvent());
         },
         child: BlocBuilder(
           bloc: _bloc,
           builder: (context,state){
             if(state is InitialCollaborateForumState){
               return Container();
             }
             if(state is LoadingForumState){
               return Center(child: CircularProgressIndicator(),);
             }
             if(state is LoadedForumState){
               return _buildDiscussionsList(state.data);
             }
           },
           
         ),
       ),
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add),
         onPressed: (){
           Navigator.of(context).push(
             MaterialPageRoute(
               builder: (context) => BlocProvider.value(
                 value: _bloc,
                 child: DiscussionFormView(),
               ),
             ),
           );
         },
       ),
    );
  }
}