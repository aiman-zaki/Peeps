import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';

import 'package:peeps/resources/groupworks_repository.dart';
import 'package:peeps/resources/user_repository.dart';

import 'package:peeps/router/navigator_args.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/groupwork_hub.dart';
import 'package:peeps/screens/inbox/inbox_bottombar.dart';
import 'package:peeps/screens/user/joined_group.dart';
import 'package:peeps/screens/user/account.dart';
import 'package:peeps/screens/user/search.dart';
import 'screens/home/drawer.dart';
import 'package:peeps/routing_constant.dart';
Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name){
    case HomeViewRoute:
      return CupertinoPageRoute(builder: (context) => DrawerView());
    case AccountViewRoute:
      final NavigatorArguments args = settings.arguments;

      return CupertinoPageRoute(builder: (context) => 
        BlocProvider(
            builder: (context) => ProfileFormBloc(repository: const UserRepository(), bloc: args.bloc),
              child: AccountView(data: args.data,)));
    case GroupsViewRoute:
      final NavigatorArguments args = settings.arguments;
      return CupertinoPageRoute<GroupworksView>(
                builder: (context) {
                  return BlocProvider<GroupworkBloc>.value(
                    value: GroupworkBloc(repository: GroupworksRepository(), usersRepository: const UserRepository()),
                    child: GroupworksView(user: args.data),
                  );
                }
              );
    case InboxBottomBarViewRoute:
      return CupertinoPageRoute(builder: (context) {
        return BlocProvider<InboxBloc>.value(
          value: InboxBloc(repository: UserRepository(),profileBloc: ProfileBloc(repository: const UserRepository())),
          child: InboxBottomBarView(),
        );
      });
    case SearchViewRoute:
      return CupertinoPageRoute(builder: (context){
        return BlocProvider<SearchGroupsBloc>(
          builder: (context) => SearchGroupsBloc(repository: GroupworksRepository(), usersRepository: const UserRepository()),
          child: SearchView());
      });
    case GroupViewRoute:
      final NavigatorArguments args = settings.arguments;
      print(args.data);
      return CupertinoPageRoute(builder: (context) => GroupworkHub(groupData:args.data['groupData'],userData: args.data['userData'],));
    default:
      return MaterialPageRoute(builder: (context) => DrawerView());
  }
}