import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peeps/router.dart' as router;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/resources/auth_repository.dart';

import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/routing_constant.dart';
import 'package:peeps/screens/account.dart';
import 'package:peeps/screens/common.dart';
import 'package:peeps/screens/splash_page.dart';
import 'package:peeps/screens/login_page.dart';
import 'package:peeps/screens/home.dart';

import 'bloc/simple_bloc_delegate.dart';

StreamSubscription periodicSub;

void main() {
  //RefreshToken
  
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = AuthRepository();
  periodicSub = Stream.periodic(Duration(minutes: 15)).listen((_)=> userRepository.refreshToken());
  runApp(
    BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(repositry: userRepository)
          ..dispatch(AppStarted());
      },
      child: BlocProvider<ProfileBloc>(
        builder: (context) => ProfileBloc(),
        child: App(userRepository: userRepository),
      )
    ),
  );
}

class App extends StatefulWidget{
  final AuthRepository userRepository;
  App({Key key, @required this.userRepository}) : super(key: key);
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[800],
        accentColor: Colors.cyan[600]
      ),
      initialRoute: HomeViewRoute,
      onGenerateRoute: router.generateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUninitialized) {
            return SplashScreen();
          }
          if (state is AuthenticationAuthenticated) {
            return HomeView();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: widget.userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}

