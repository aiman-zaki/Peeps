import 'package:flutter/material.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';

class WelcomeGroupworkHubDialog extends StatelessWidget {
  final GroupworkModel groupwork;
  
  const WelcomeGroupworkHubDialog({
    Key key,
    @required  this.groupwork,
    }) : super(key: key);

  _buildHeader(){
    return Text("Hey, welcome to ${groupwork.name} hub views");
  }
  _buildBody(){
    return Container(
      padding: EdgeInsets.all(9),
      child: Column(
        children: <Widget>[

      ],),
    );
  }
  _buildTemplateOnly(){
    return Container(
      padding: EdgeInsets.all(9),
      child: Column(
        children: <Widget>[
          Text("Template",textAlign: TextAlign.start,),
          SizedBox(height: 10,),
          Text("1. Your Supervisor will have full controlled of assignments and tasks"),
          Text("2. Tasks difficulties will effect your scoring, choose wisely :)"),
      ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWithAvatar(
      width: 500,
      height: 360,
      avatarIcon: Icon(Icons.info),
      description: "Hey, welcome to ${groupwork.name} hub views",
      title: Center(child: Text("Welcome",style: TextStyle(fontSize: 26,),textAlign: TextAlign.center,)),
      children: <Widget>[
      Divider(height: 1.00,),  
      _buildBody(),
      _buildTemplateOnly(),
      SizedBox(height: 20,),
      Text("Goodluck and Havefun!")
      ],
      bottomRight: FlatButton(
        child: Text("Features"),
        onPressed: (){

        },
      ),
    );
  }
}