import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/user_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import '../bloc.dart';

class GroupworkBloc extends Bloc<GroupworkEvent, GroupworkState> {
  final GroupworkRepository repository;
  final UserRepository usersRepository;
  GroupworkBloc({
    @required this.repository,
    @required this.usersRepository,
  });


  @override
  GroupworkState get initialState => InitialGroupworkState();

  @override
  Stream<GroupworkState> mapEventToState(
    GroupworkEvent event,
  ) async* {
    if(event is NewGroupButtonPressedEvent){
      yield InsertingGroupworkState();
      //TODO : TEMPSOLUTION
      Map data = new Map();
      data['name'] = event.name;
      data['description'] = event.description;
      data['course'] = event.course;
      data['members'] = event.members;
      await repository.createGroupwork(data);  
      yield InsertedGroupworkState();
    
    }
    if(event is LoadGroupworkEvent){
      yield LoadingGroupworkState();
      if(event.data.isEmpty){
          yield NoGroupworkState();
      } else {
        List<GroupworkModel> activeGroups = await usersRepository.readActiveGroupworks();
        yield LoadedGroupworkState(data:activeGroups);
      }
    }
  }
}
