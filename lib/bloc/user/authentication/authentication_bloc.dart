import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/auth_repository.dart';
import '../bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository repositry;
  

  AuthenticationBloc({@required this.repositry}): assert(repositry != null);
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
      if(event is AppStarted){
        final bool hasToken = await repositry.hasToken();

        if(hasToken){
          yield AuthenticationAuthenticated();
        } else {
          yield AuthenticationUnauthenticated();
        }
      }
      if(event is LoggedIn){
        yield AuthenticationLoading();
        yield AuthenticationAuthenticated();
          
      }
      if(event is LoggedOut){
        yield AuthenticationLoading();
        await repositry.deleteToken();
        yield AuthenticationUnauthenticated();
      }

  }
}
