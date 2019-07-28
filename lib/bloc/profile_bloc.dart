import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/users_repository.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final repository;

  ProfileBloc({
    @required this.repository,
  }

  );
  
  @override
  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if(event is LoadProfile){
      yield ProfileLoading(); 
      Map data = await repository.fetchProfile();
      UserModel user = UserModel.fromJson(data);
      yield ProfileLoaded(data:user);

    }
  }
}
