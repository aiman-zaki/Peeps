import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/screens/profile.dart';

class AccountView extends StatelessWidget {
  final UserModel data;
  const AccountView({Key key,@required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
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

      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0.00,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text('Account'),
        ),
        body: Container(
          child: _listView(context),
        ),
      );
      
    }
}