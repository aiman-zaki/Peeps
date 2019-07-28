import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import './bloc.dart';

class GroupworkBloc extends Bloc<GroupworkEvent, GroupworkState> {
  final GroupworkRepository repository;
  
  GroupworkBloc({
    @required this.repository
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
      List<dynamic> datas = await repository.fetchGroupworkDetail(event.data);
      List<GroupworkModel> groupworks = [];
      for(Map<String,dynamic> data in datas){
        groupworks.add(GroupworkModel.fromJson(data));
      }
      yield LoadedGroupworkState(data:groupworks);
    }
  }
}
