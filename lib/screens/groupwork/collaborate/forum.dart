import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/collaborate_forum/collaborate_forum_bloc.dart';
import 'package:peeps/resources/discussion_repository.dart';
import 'package:peeps/screens/groupwork/collaborate/discussion.dart';
import 'package:peeps/screens/groupwork/collaborate/discussion_form.dart';

class CollaborateForumView extends StatefulWidget {
  final isAdmin;
  final course;
  CollaborateForumView({Key key,this.course,@required this.isAdmin}) : super(key: key);

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
              onLongPress: widget.isAdmin?
              (){
                _bloc.add(DeleteDiscussionEvent(data: {'forum_id':data[index].id}));
              }: null,
              onTap: (){
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => CollaborateDiscussionBloc(repository: DiscussionRepository(data: widget.course,data2: data[index].id)),
                      child: DiscussionView(isAdmin: widget.isAdmin ,),
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
           _bloc.add(LoadForumEvent());
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
               if(state.data.isNotEmpty){
                 return _buildDiscussionsList(state.data);
               }
               return Center(child: Text("No Data"),);
             }
           },
           
         ),
       ),
      floatingActionButton: !widget.isAdmin?
       FloatingActionButton(
         child: Icon(Icons.add),
         onPressed: (){
           Navigator.of(context).push(
             MaterialPageRoute(
               builder: (context) => BlocProvider.value(
                 value: _bloc,
                 child: DiscussionFormView(isAdmin: widget.isAdmin),
               ),
             ),
           );
         },
       ) : null
    );
  }
}