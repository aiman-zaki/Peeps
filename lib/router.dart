import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/supervisor/bloc.dart';

import 'package:peeps/resources/groupworks_repository.dart';
import 'package:peeps/resources/stats_repository.dart';
import 'package:peeps/resources/supervise_groupworks_repository.dart';
import 'package:peeps/resources/supervisor_courses_repository.dart';
import 'package:peeps/resources/user_repository.dart';
import 'package:peeps/resources/users_repository.dart';

import 'package:peeps/router/navigator_args.dart';
import 'package:peeps/screens/admin/admin_hub.dart';
import 'package:peeps/screens/admin/users.dart';
import 'package:peeps/screens/groupwork/groupwork_hub/groupwork_hub.dart';
import 'package:peeps/screens/inbox/inbox_bottombar.dart';
import 'package:peeps/screens/supervisor/courses_supervise.dart';
import 'package:peeps/screens/supervisor/groupworks_supervise.dart';
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
            create: (context) => ProfileFormBloc(repository: const UserRepository(), bloc: args.bloc),
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
          create: (context) => SearchGroupsBloc(repository: GroupworksRepository(), usersRepository: const UserRepository()),
          child: SearchView());
      });
    case GroupViewRoute:
      final NavigatorArguments args = settings.arguments;
      return CupertinoPageRoute(builder: (context) => GroupworkHub(groupData:args.data['groupData'],userData: args.data['userData'],));
    case SuperviseGroupworks:
      return CupertinoPageRoute(builder: (context){
        return MultiBlocProvider(
          child: GroupworksSuperviseView(),
          providers: [
            BlocProvider<GroupworksSuperviseBloc>(
              create: (context) => GroupworksSuperviseBloc(repository: SuperviseGroupworksRepository())..add(ReadGroupworksSuperviseEvent()),
            ),
            BlocProvider<CoursesSupervisorBloc>(
              create: (context) => CoursesSupervisorBloc(repository: SupervisorRepository())..add(ReadCoursesSupervisorEvent()),
            ),
          ],
        );
      });
    case SuperviseCourse:
      return CupertinoPageRoute(
        builder: (context) => BlocProvider<CoursesSupervisorBloc>(create: (context) => CoursesSupervisorBloc(repository: SupervisorRepository())..add(ReadCoursesSupervisorEvent()),child: CoursesSuperviseView(),));
    case SuperuserUsers:
      return CupertinoPageRoute(
        builder: (context) => MultiBlocProvider(
          child: AdminHubView(),
          providers: [
            BlocProvider<AdminUsersBloc>(create: (context) => AdminUsersBloc(repository: UsersRepository())..add(ReadUsersEvent())),
            BlocProvider<AdminDashboardBloc>(create: (context) => AdminDashboardBloc(repository: StatsRepository())),
          ],
        ));

    default:
      return MaterialPageRoute(builder: (context) => DrawerView());
  }
}