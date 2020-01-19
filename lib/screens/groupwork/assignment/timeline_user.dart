import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/models/contribution.dart';
import 'package:peeps/screens/common/tag.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';


class TimelineUserView extends StatefulWidget {
  TimelineUserView({Key key}) : super(key: key);

  @override
  _TimelineUserViewState createState() => _TimelineUserViewState();
}

class _TimelineUserViewState extends State<TimelineUserView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<AssignmentTimelineUserBloc>(context);
    final size = MediaQuery.of(context).size;
    return BlocBuilder(
      bloc:_bloc,
      builder: (context,state){
        if(state is LoadingAssignmentTimelineUserState){
          return Center(child: CircularProgressIndicator(),);
        } 
        if(state is LoadedAssignmentTimelineUserState){
           List<TimelineModel> items = state.contributions.map((ContributionModel data){
              return TimelineModel(
                Card(
                  child: Container(
                    width: size.width,
                    height: 150,
                    padding: EdgeInsets.all(9),
                    child: Column(
                      children: <Widget>[
                        Text("${data.who}"),
                        Text(DateFormat.yMd().format(data.when)),
                      ],
                    ),
                  ),
                ),
                position: TimelineItemPosition.random,
              
              );              
            }).toList().cast<TimelineModel>();
            print(items);
          

          return Column(
            children: <Widget>[
              CustomTag(
                color: Colors.blue,
                text: Text("Contribution Score : ${state.score}"),
                padding: EdgeInsets.all(18),
              ),
              Expanded(child: Timeline(children: items,position: TimelinePosition.Center,))
            ],
          );
        }
      },
    );
  }
}