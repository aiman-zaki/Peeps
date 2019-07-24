import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/screens/profile.dart';

class AccountView extends StatelessWidget {
  
  const AccountView({Key key}) : super(key: key);
  
  Widget _listView(BuildContext context){
    return ListView(
      children: <Widget>[
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Hero(tag:'profiletag',child: Material(child:Text("Profile"),type: MaterialType.transparency,),),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.push(context,CupertinoPageRoute(builder: (context) => ProfileView()));
            },
          ),
        ListTile(
          leading: Icon(Icons.security),
          title: Text('Security'),
          trailing: Icon(Icons.keyboard_arrow_right),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
        ),
        body: Container(
          child: _listView(context),
        ),
      );
      
    }
}