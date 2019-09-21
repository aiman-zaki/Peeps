import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:peeps/resources/users_repository.dart';
import '../bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UsersRepository repository;
  final LoginBloc loginBloc;
  RegisterBloc({
    @required this.repository,
    @required this.loginBloc,
  });
  
  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is RegisterButtonClickedEvent){
      yield RegisteringUserState(message: "Registering User");
      try{
        await repository.createUser(event.email,event.password);
      } catch (e){
        yield ErrorMessageState(message: e.toString());
      }
      yield RegisteredUserState();
      if(event.image != null){
        yield UploadingInitProfilePictureState();
        try{
          //await repository.updateProfilePicture(event.image);
        }catch(e){
          yield ErrorMessageState(message: e.toString());
        }
        yield UploadedInitProfilePictureState();
      }
      yield CompletedRegisterState();
      loginBloc.dispatch(LoginButtonPressed(email: event.email,password: event.password));

    }
  }
}
