import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peeps/screens/joined_group.dart';
import 'package:peeps/screens/account.dart';
import 'package:peeps/screens/profile.dart';
import 'screens/home.dart';
import 'package:peeps/routing_constant.dart';
Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name){
    case HomeViewRoute:
      return CupertinoPageRoute(builder: (context) => HomeView());
    case AccountViewRoute:
      return CupertinoPageRoute(builder: (context) => AccountView());
    case GroupsViewRoute:
      return CupertinoPageRoute(builder: (context) => GroupsView());
    default:
      return MaterialPageRoute(builder: (context) => HomeView());
  }
}