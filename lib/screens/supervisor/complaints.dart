import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/models/complaint.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';

import 'complaint_resolve_form.dart';


class GroupworkComplaintView extends StatefulWidget {
  final List<ComplaintModel> complaints;
  GroupworkComplaintView({Key key,@required this.complaints}) : super(key: key);

  @override
  _GroupworksComplaintViewState createState() => _GroupworksComplaintViewState();
}

class _GroupworksComplaintViewState extends State<GroupworkComplaintView> {
  @override
  Widget build(BuildContext context) {
    var _bloc  = BlocProvider.of<ComplaintBloc>(context);
    final List<ComplaintModel> complaints = widget.complaints;

    _buildResolveForm(ComplaintModel complaint){
      return <Widget>[
        
      ];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaints"),
      ),
      body:  Container(
      padding: EdgeInsets.all(9),
      child: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context,index){
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                color: Colors.green,
                icon: Icons.check,
                caption: "Resolve",
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => 
                        BlocProvider.value(value: _bloc,child: ComplaintResolveFormView(complaint: complaints[index],),)
                    ));
                    
                },
              )
            ],
            child: ListTile(
              title: Text("${complaints[index].title}"),
              subtitle: Text("${complaints[index].by}"),
            ),
          );
          },
        ),
      ),
    );
  }
}