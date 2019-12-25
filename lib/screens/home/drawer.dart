import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/configs/theme.dart';
import 'package:peeps/enum/role_enum.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/router/navigator_args.dart';
import 'package:peeps/routing_constant.dart';
import 'package:showcaseview/showcaseview.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerView extends StatefulWidget {
  DrawerView({Key key}) : super(key: key);

  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  UserModel currentUser;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent());
    currentUser = UserModel.defaultConst();
  }

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _profileBloc = BlocProvider.of<ProfileBloc>(context);

    _theme() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.getBool('theme') != null ? preferences.getBool('theme') : true;
    }

    _themeSwitch() {
      return FutureBuilder(
        future: _theme(),
        builder: (context, theme) {
          if (theme.connectionState == ConnectionState.done) {
            return ListTile(
              title: Text("Dark Mode"),
              trailing: Switch(
                activeColor: Theme.of(context).accentColor,
                value: theme.data,
                onChanged: (val) {
                  setState(() {
                    ThemeController.setTheme(val);
                    showDialog(
                      context: context,
                      builder: (context){
                        return SimpleDialog(
                          title: Text("Alert!"),
                          children: <Widget>[
                            Center(child: Text("Restart the app to apply changes"))
                          ],
                        );
                      }
                    );
                  });
                },
              ),
            );
          }
          return Container();
        },
      );
    }

    Drawer _drawerContent(BuildContext context, user) {
      DrawerHeader header = new DrawerHeader(
        child: Column(
          children: <Widget>[
            Text(user.email),
            Text(getRoleStringEnum(user.role))
          ],
        ),
      );

      ListTile item(IconData icon, String title, String routeName) {
        return new ListTile(
          leading: new Icon(icon),
          title: new Text(title),
          onTap: () {
            if (routeName == "/") {
              Navigator.pushReplacementNamed(context, routeName);
            } else if (routeName == AccountViewRoute ||
                routeName == GroupsViewRoute) {
              Navigator.pushNamed(context, routeName,
                  arguments:
                      NavigatorArguments(bloc: _profileBloc, data: user));
            } 
            else {
              Navigator.pushNamed(context, routeName);
            }
          },
        );
      }

      List<Widget> drawerChildren = [
        header,
        item(Icons.mail, "Inbox", InboxBottomBarViewRoute),
        item(Icons.group, "Groups", GroupsViewRoute),
        item(Icons.search, "Groups Search", SearchViewRoute),
        currentUser.role.index == 2 ?
          Container()
        : item(Icons.supervisor_account, 'Groups Supervised',SuperviseGroupworks),
        currentUser.role.index == 2?
          Container()
        : item(Icons.code, 'Course',SuperviseCourse),
        currentUser.role == Role.admin ?
          item(FontAwesomeIcons.superpowers, 'SuperUser',SuperuserUsers)
        : Container(),
        _themeSwitch(),
      ];

      Widget _footerDrawer() {
        return Container(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              child: Column(
                children: <Widget>[
       
                  Divider(),
                  item(Icons.account_box, "Account", AccountViewRoute),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () {
                      Navigator.pop(context);
                      _authBloc.add(LoggedOut());
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }

      ListView listView = new ListView(children: drawerChildren);
      return new Drawer(
        child: new Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: listView,
            ),
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
        listener: (context, state) {
          if (state is ProfileLoading) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Loading User Information"),
            ));
          }
          if (state is ProfileLoaded) {
            setState(() {
              currentUser = state.data;
            });
            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text("User Information Loaded"),
              ),
            );
          }
        },
        child: new SingleChildScrollView(
          child: ShowCaseWidget(
            builder: Builder(builder: (context) => HomeView(),),
          ),
        ),
      ),
      drawer: _drawerContent(context, currentUser),
    );
  }
}
