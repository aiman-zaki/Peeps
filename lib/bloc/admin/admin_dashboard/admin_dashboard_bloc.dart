import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:peeps/global/chart.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/stats_repository.dart';
import './bloc.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  
  final StatsRepository repository;

  AdminDashboardBloc({
    @required this.repository
  });
  
  @override
  AdminDashboardState get initialState => InitialAdminDashboardState();

  _generateJoinedUser(data){
    Map<int,int> yearCount = {}; 
    List<UsersGrowthPerYear> users = [];
    //Todo: should be server sided
     for(UserModel user in data){
        if(!yearCount.containsKey(user.createdDate.year)){
          yearCount[user.createdDate.year] = 1;
        } else {
          yearCount[user.createdDate.year] = yearCount[user.createdDate.year]+1;
        }
      }
      yearCount.forEach((k,v){
        users.add(UsersGrowthPerYear(year:k.toString(),no: v,color: Colors.blue));
      });
    return users;
  }

  @override
  Stream<AdminDashboardState> mapEventToState(
    AdminDashboardEvent event,
  ) async* {
    if(event is GenerateAdminDashboard){
    yield GeneratingAdminDashboardState();
    Map<String,dynamic> data = {};
    data['joined'] = _generateJoinedUser(event.data);
    data['active_user'] = await repository.readUsersActivePerWeek();
    print(data['active_user']);
    yield GeneratedAdminDashboardState(data: data);
   }
  }
}
