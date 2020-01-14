import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/global/chart.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/screens/admin/users.dart';
import 'package:peeps/screens/admin/users_growth_chart.dart';
import 'package:peeps/screens/splash_page.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AdminHubView extends StatefulWidget {
  AdminHubView({Key key}) : super(key: key);

  @override
  _AdminHubViewState createState() => _AdminHubViewState();
}

class _AdminHubViewState extends State<AdminHubView> {
  @override
  Widget build(BuildContext context) {
    final _usersBloc = BlocProvider.of<AdminUsersBloc>(context);
    final _usersChartsBloc = BlocProvider.of<AdminDashboardBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Hub"),
      ),
      body: Column(
        children: <Widget>[
          UsersGrowthCharts(),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Card(
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                  builder: (context) => BlocProvider<AdminUsersBloc>.value(value: _usersBloc,child: UsersListView())
                  ),
                );
              },
              leading: Icon(Icons.people_outline),
              title: Text("Users"),),),
              Card(
                child: ListTile(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                      builder: (context) => BlocProvider<AdminUsersBloc>(create: (context) => AdminUsersBloc(repository: UsersRepository())..add(ReadUsersEvent()),
                        child:  UsersListView(),
                      )),
                    );
                  },
                  leading: Icon(Icons.people_outline),
                  title: Text("Courses"),),)
              
          ],
        ),
      ),
    );
  }
}