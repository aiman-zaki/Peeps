import 'package:equatable/equatable.dart';

abstract class AdminUsersEvent extends Equatable {
  const AdminUsersEvent();
}

class ReadUsersEvent extends AdminUsersEvent{
  
  @override
  List<Object> get props => [];
  
  @override
  String toString() => "ReadUsersEvent";
}