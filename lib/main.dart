import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peeps/global/notification_manager.dart';
import 'package:peeps/resources/user_repository.dart';

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

import 'package:http/http.dart' as http;
//TODO POINT SYSTEM FOR GROUPWORK

StreamSubscription periodicSub;
StreamSubscription tryLocalNotification;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  NotificationManager notificationManager = NotificationManager();
  final authRepository = AuthRepository();
  final userRepository = UserRepository();

  var theme = await ThemeController.getTheme();

  //RefreshToken
  periodicSub = Stream.periodic(Duration(minutes: 15)).listen((_)=> authRepository.refreshToken());
  //Stream.periodic(Duration(minutes: 1)).listen((_) => notificationManager.pollingSupervisorNotification(flutterLocalNotificationsPlugin));
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
          return AuthenticationBloc(repositry: authRepository)
            ..add(AppStarted());
          },),
        BlocProvider<ProfileBloc>(
          create: (context) {
            return ProfileBloc(repository: userRepository);
          },), 
        BlocProvider<UserTaskBloc>(
          create: (context){
            return UserTaskBloc(usersRepository: userRepository);
          },
        ),
        BlocProvider<AssignmentsBloc>(
          create: (context) => AssignmentsBloc(repository: userRepository),
        ),
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

  Future<void> _showNotification() async {
    var response = await http.get(
      'http://10.0.2.2:5000/api/stats/users/perweek'
    );

    var jsonEncode = jsonDecode(response.body);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'yo yo yo', 'noti noti noti', 'aaaaaaa',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '${jsonEncode}', 'plain body', platformChannelSpecifics,
        payload: 'item x');
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

