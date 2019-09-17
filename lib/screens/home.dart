import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/router/navigator_args.dart';
import 'package:peeps/routing_constant.dart';


class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserModel currentUser;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).dispatch(LoadProfileEvent());
    currentUser = UserModel.defaultConst(); 
  }

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
              
              Navigator.pushNamed(context, routeName,arguments: NavigatorArguments(
                bloc: _profileBloc,
                data: user
              ));
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

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: BlocListener(
        bloc: _profileBloc,
        listener: (context,state){
          if(state is ProfileLoading){
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Loading User Information"),
              )
            );
          }
          if(state is ProfileLoaded){
            setState(() {
              currentUser = state.data;
            });
            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("User Information Loaded"),
              ),
            );
          }
        },
        child: new Container(
          child: new Center(

          ),
        ),
      ),
      drawer: _drawerContent(context,currentUser),
    
    );
  }

}
