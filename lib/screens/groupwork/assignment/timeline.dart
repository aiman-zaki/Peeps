import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/enum/contribution_enum.dart';
import 'package:peeps/models/contribution.dart';
import 'package:peeps/screens/common/tag.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:peeps/screens/splash_page.dart';

class AssignmentTimelineView extends StatefulWidget {
  AssignmentTimelineView({Key key}) : super(key: key);

  @override
  _AssignmentTimelineViewState createState() => _AssignmentTimelineViewState();
}

class _AssignmentTimelineViewState extends State<AssignmentTimelineView> {
  Map<String,dynamic> _getWhatIcon(WhatEnum what){

    Map<String,dynamic> data = {};
    switch (what) {
      case WhatEnum.create: 
        data['icon'] = Icons.create;
        data['color'] = Colors.green;
        break;
      case WhatEnum.delete:
        data['icon'] = Icons.delete;
        data['color'] = Colors.red;
        break;

      case WhatEnum.update:
        data['icon'] = Icons.update;
        data['color'] = Colors.yellow;
        break;
      case WhatEnum.deny:
      default:
        data['icon'] = FontAwesomeIcons.unlock;
        data['color'] = Colors.grey;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<AssignmentTimelineBloc>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context,state){
          if(state is InitialAssignmentTimelineState){
            return SplashScreen();
          }
          if(state is LoadingAssignmentTimelineState){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is LoadedAssignmentTimelineState){
            List<TimelineModel> items = state.data.map((ContributionModel data){
              Map<String,dynamic> iconData = _getWhatIcon(data.what);
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
                icon: Icon(iconData['icon']),
                iconBackground: iconData['color'],
              );              
            }).toList().cast<TimelineModel>();
            print(items);
            return Timeline(children: items,position: TimelinePosition.Center,);
          }
        },
      ),
    );
  }
}