import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/resources/auth_repository.dart';

import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/screens/login_form.dart';

class LoginPage extends StatelessWidget {
  final AuthRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        builder: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            repository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}