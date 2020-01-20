import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/enum/contribution_enum.dart';
import 'package:peeps/models/contribution.dart';
import 'package:peeps/screens/common/tag.dart';
import 'package:peeps/screens/splash_page.dart';
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

    Map<String,dynamic> _getWhatIcon(WhatEnum what){

    Map<String,dynamic> data = {};
    switch (what) {
      case WhatEnum.create: 
        data['color'] = Colors.green;
        break;
      case WhatEnum.delete:
        data['color'] = Colors.red;
        break;

      case WhatEnum.update:
        data['color'] = Colors.amber;
        break;
      case WhatEnum.deny:
      default:
        data['color'] = Colors.grey;
    }
    return data;
  }
    

    _buildContributionsList(List<ContributionModel> data){
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          var color = _getWhatIcon(data[index].what);
          return Card(
            color: color['color'],
            child: ListTile(
              trailing: Text(DateFormat.yMd().add_jm().format(data[index].when).toString()),
              title: Text(data[index].display()),
            ),
          );
        },
      );
    }


    return BlocBuilder(
      bloc:_bloc,
      builder: (context,state){
        if(state is InitialAssignmentTimelineState){
          return SplashScreen();
        }
        if(state is LoadingAssignmentTimelineUserState){
          return Center(child: CircularProgressIndicator(),);
        } 
        if(state is LoadedAssignmentTimelineUserState){
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               CustomTag(text: Text("Contribution Score: ${state.score.toString()}",textAlign: TextAlign.center,),color: Colors.blue, padding: EdgeInsets.all(13),),
               Expanded(child: _buildContributionsList(state.contributions)),
             ],
           );
          }
      
      });
  }
}