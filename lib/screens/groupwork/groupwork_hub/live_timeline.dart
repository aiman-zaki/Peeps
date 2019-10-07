import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/bloc/groupwork/timeline/timeline_bloc.dart';
import 'package:peeps/bloc/groupwork/timeline/timeline_event.dart';

class LiveTimelineView extends StatefulWidget {

  final groupData;



  LiveTimelineView({Key key,@required this.groupData}) : super(key: key);

  _LiveTimelineViewState createState() => _LiveTimelineViewState();
}

class _LiveTimelineViewState extends State<LiveTimelineView> {  

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<TimelineBloc>(context);
    final _scrollController = new ScrollController();

   _scrollToTop(){
     Future.delayed(const Duration(milliseconds: 500),(){
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
     });
    }
    return Column(
      children: <Widget>[
        BlocBuilder<TimelineBloc,TimelineState>(
          bloc: _bloc,
          builder: (context,state){
            if(state is InitialTimelineState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is ConnectedTimelineState){
              return Column(
                children: <Widget>[
                  Text('Latest Activity',style: TextStyle(fontSize: 22),),
                  Container(
                    height: 150.00,
                    child: Card(
                      elevation: 8.00,
                      color: Colors.grey[900],
                      child: StreamBuilder(
                        stream: state.repo.timelineStream,
                        builder: (context,snapshot){

                          return ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: state.repo.timelines.length,
                            itemBuilder: (context,index){
                               _scrollToTop();
                              return ListTile(
                                title: Text(state.repo.timelines[index].by),
                                subtitle: Text(state.repo.timelines[index].description),
                                trailing: Text(DateFormat.yMd().add_jm().format(state.repo.timelines[index].createdDate)),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}