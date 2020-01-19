import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/global/chart.dart';
import 'package:peeps/resources/bulletin_board_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/screens/admin/bulletin_form.dart';
import 'package:peeps/screens/admin/courses.dart';
import 'package:peeps/screens/admin/users.dart';
import 'package:peeps/screens/admin/users_growth_chart.dart';
import 'package:peeps/screens/home/bulletin_board.dart';
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
    final _coursesBloc =BlocProvider.of<AdminCoursesBloc>(context);
    final _usersChartsBloc = BlocProvider.of<AdminDashboardBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Hub"),
      ),
      body: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => BlocProvider.value(value:_usersBloc,child: UsersListView())
                    )
                  );
                },
                child: Container(
                  height: 180,
                  child: Card(
                    child: Center(child: Text("Users"),),),
                ),
              ),),
            Expanded(
              child: InkWell(
                 onTap: (){
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => BlocProvider.value(value: _coursesBloc, child: CoursesListView(),)
                    )
                  );
                },
                child: Container(
                  height: 180,
                  child: Card(
                    child: Center(child: Text("Courses"),),),
                ),
              ),),
          ],),
          Row(
            children: <Widget>[
              Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => BlocProvider(create: (context) => AdminBulletinBoardBloc(repository: BulletinBoardRepository()),child: BulletinFormView())
                    )
                  );
                },
                child: Container(
                  height: 180,
                  child: Card(
                    child: Center(child: Text("Bulletin Form"),),),
                ),
              ),),
              Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => BlocProvider(create: (context) => AdminBulletinBoardBloc(repository: BulletinBoardRepository())..add(ReadBulletinBoardEvent()),
                      child: BulletinBoardView(isAdmin: true,))
                    )
                  );
                },
                child: Container(
                  height: 180,
                  child: Card(
                    child: Center(child: Text("Bulletin Board"),),),
                ),
              ),),
            ],
          )
        
        
        ],
      ),
      
    );
  }
}