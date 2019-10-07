import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/router.dart' as router;
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/auth_repository.dart';

import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/routing_constant.dart';

import 'package:peeps/screens/splash_page.dart';
import 'package:peeps/screens/auth/login_page.dart';
import 'package:peeps/screens/home/drawer.dart';

import 'bloc/simple_bloc_delegate.dart';
import 'configs/theme.dart';

StreamSubscription periodicSub;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final authRepository = AuthRepository();
  final userRepository = UsersRepository();

  var theme = await ThemeController.getTheme();
    //RefreshToken
  periodicSub = Stream.periodic(Duration(minutes: 15)).listen((_)=> authRepository.refreshToken());
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          builder: (context) {
          return AuthenticationBloc(repositry: authRepository)
            ..dispatch(AppStarted());
          },),
        BlocProvider<ProfileBloc>(
          builder: (context) {
            return ProfileBloc(repository: userRepository);
          },), 
        BlocProvider<UserTaskBloc>(
          builder: (context){
            return UserTaskBloc(usersRepository: userRepository);
          },
        )
      ],
      child: App(userRepository: authRepository,theme: theme,),
    )
  );
}

class App extends StatefulWidget{
  final AuthRepository userRepository;
  final theme;
  App({Key key, @required this.userRepository, this.theme}) : super(key: key);
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('logo');
 
    var initializationSettings = InitializationSettings(
      initializationSettingsAndroid,null
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  widget.theme,
      initialRoute: HomeViewRoute,
      onGenerateRoute: router.generateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUninitialized) {
            return SplashScreen();
          }
          if (state is AuthenticationAuthenticated) {
            
            return DrawerView();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: widget.userRepository);
          }
          if (state is AuthenticationLoading) {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

