import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/authentication_bloc.dart';
import 'package:peeps/bloc/authentication_event.dart';
import 'package:peeps/routing_constant.dart';

class HomeView extends StatelessWidget{

  Drawer _drawerContent(BuildContext context){
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    DrawerHeader header = new DrawerHeader(
      child: Text("#email"),
    );

    ListTile item(IconData icon,String title,String routeName){
      return new ListTile(
        leading: new Icon(icon),
        title: new Text(title),
        onTap: (){
          if(routeName == "/"){
            Navigator.pushReplacementNamed(context, routeName);
          } else {
            Navigator.pushNamed(context, routeName);
          }
        },
      );
    }

    List<StatelessWidget> drawerChildren = [
      header,
      item(Icons.home, "Home", HomeViewRoute),
      item(Icons.people, "Account" , AccountViewRoute),
      item(Icons.group, "Groups", GroupsViewRoute),
      item(Icons.group, "Inbox", InboxBottomBarViewRoute)
      
    ];
    Widget _footerDrawer(){
      return Container(
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            child: Column(
              children: <Widget>[
                Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: (){
                    Navigator.pop(context);
                    _authBloc.dispatch(LoggedOut());                  
                  },
                )
              ],
            ),
          ),
        ),
      );
    }
    ListView listView = new ListView(children:drawerChildren);
    return new Drawer(
      child: new Column(
        
        children: <Widget>[
          Expanded(child: listView,),
          _footerDrawer(),
        ],
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {

    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Container(
        child: new Center(

        ),
      ),
      drawer: _drawerContent(context),
    
    );
  }
}