import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:peeps/resources/auth_repository.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository repository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.repository,
    @required this.authenticationBloc,
  }) : assert(repository != null), assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginButtonPressed){
      yield LoginLoading();

      try{
        await repository.authenticate(email: event.email,password: event.password);
        authenticationBloc.dispatch(LoggedIn());
        yield LoginInitial();
      } catch (error){
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
