import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/screens/inbox_invitation.dart';
import 'package:peeps/screens/inbox_bottombar.dart';
import 'package:peeps/screens/joined_group.dart';
import 'package:peeps/screens/account.dart';
import 'package:peeps/screens/profile.dart';
import 'package:peeps/screens/search.dart';
import 'screens/home.dart';
import 'package:peeps/routing_constant.dart';
Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name){
    case HomeViewRoute:
      return CupertinoPageRoute(builder: (context) => HomeView());
    case AccountViewRoute:
      return CupertinoPageRoute(builder: (context) => AccountView(data: settings.arguments,));
    case GroupsViewRoute:
      return CupertinoPageRoute<GroupworksView>(
                builder: (context) {
                  return BlocProvider<GroupworkBloc>.value(
                    value: GroupworkBloc(repository: GroupworkRepository()),
                    child: GroupworksView(user:settings.arguments),
                  );
                }
              );
    case InboxBottomBarViewRoute:
      return CupertinoPageRoute(builder: (context) {
        return BlocProvider<InboxBloc>.value(
          value: InboxBloc(repository: UsersRepository(),profileBloc: ProfileBloc(repository: UsersRepository())),
          child: InboxBottomBarView(),
        );
      });
    case SearchViewRoute:
      return CupertinoPageRoute(builder: (context){
        return SearchView();
      });
    default:
      return MaterialPageRoute(builder: (context) => HomeView());
  }
}