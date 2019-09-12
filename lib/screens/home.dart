import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/routing_constant.dart';



class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
   
   
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _profileBloc = BlocProvider.of<ProfileBloc>(context);


    Drawer _drawerContent(BuildContext context,user){
      DrawerHeader header = new DrawerHeader(
        child: Text(user.email),
      );

      ListTile item(IconData icon,String title,String routeName){
        return new ListTile(
          leading: new Icon(icon),
          title: new Text(title),
          onTap: (){
            if(routeName == "/"){
              Navigator.pushReplacementNamed(context, routeName);
            }else if(routeName == AccountViewRoute || routeName == GroupsViewRoute){
              Navigator.pushNamed(context, routeName,arguments: user);
            }
            else {
              Navigator.pushNamed(context, routeName);
            }
          },
        );
      }

      List<StatelessWidget> drawerChildren = [
        header,
        item(Icons.mail, "Inbox", InboxBottomBarViewRoute),
        item(Icons.group, "Groups", GroupsViewRoute),
        item(Icons.search, "Search", SearchViewRoute)
      ];
      Widget _footerDrawer(){
        return Container(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              child: Column(
                children: <Widget>[
                  Divider(),
                  item(Icons.account_box, "Account" , AccountViewRoute),
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
  

    return BlocBuilder(
      bloc: _profileBloc,
      builder: (context,state){
        if(state is InitialProfileState){
          _profileBloc.dispatch(LoadProfile());
          return Container();
        }
        if(state is ProfileLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is ProfileLoaded){
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: new AppBar(
              title: new Text("Home"),
            ),
            body: new Container(
              child: new Center(

              ),
            ),
            drawer: _drawerContent(context,state.data),
          
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
