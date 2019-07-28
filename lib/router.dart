import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/screens/inbox.dart';
import 'package:peeps/screens/inbox_bottombar.dart';
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
      return CupertinoPageRoute<GroupsView>(
                builder: (context) {
                  return BlocProvider<GroupworkBloc>.value(
                    value: GroupworkBloc(repository: GroupworkRepository()),
                    child: GroupsView(),
                  );
                }
              );
    case InboxBottomBarViewRoute:
      return CupertinoPageRoute(builder: (context) {
        return BlocProvider<InboxBloc>.value(
          value: InboxBloc(repository: UsersRepository()),
          child: InboxBottomBarView(),
        );
      });
    default:
      return MaterialPageRoute(builder: (context) => HomeView());
  }
}