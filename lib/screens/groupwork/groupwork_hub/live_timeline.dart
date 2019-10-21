
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/bloc/groupwork/timeline/timeline_bloc.dart';


class LiveTimelineView extends StatefulWidget {

  final groupData;



  LiveTimelineView({Key key,@required this.groupData}) : super(key: key);

  _LiveTimelineViewState createState() => _LiveTimelineViewState();
}

class _LiveTimelineViewState extends State<LiveTimelineView> {  
  final _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<TimelineBloc>(context);
    

   _scrollToTop(){
     Future.delayed(const Duration(milliseconds: 500),(){
      try{
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeOut); 
      } catch(e){
        throw e.toString();
      }
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
            if(state is ConnectingTimelineState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is ConnectedTimelineState){
              return Container(
                height: 250.00,
                child: Card(
                  elevation: 8.00,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                              'Latest Activity',
                              style: TextStyle(fontSize: 16),
                            ),
                         ),
                        StreamBuilder(
                          stream: state.repo.timelineStream,
                          builder: (context,snapshot){

                            return SizedBox(
                              height: 170,
                              child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                reverse: true,
                                shrinkWrap: true,
                                itemCount: state.repo.timelines.length,
                                itemBuilder: (context,index){
                                   _scrollToTop();
                                  return ListTile(
                                    title: Text(state.repo.timelines[index].display()),
                                    subtitle: Text(state.repo.timelines[index].who),
                                    trailing: Text(DateFormat.yMd().add_jm().format(state.repo.timelines[index].when)),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}