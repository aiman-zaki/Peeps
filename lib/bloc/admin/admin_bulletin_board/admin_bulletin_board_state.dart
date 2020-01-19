import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class AdminBulletinBoardState extends Equatable {
  const AdminBulletinBoardState();
}

class InitialAdminBulletinBoardState extends AdminBulletinBoardState {
  @override
  List<Object> get props => [];
}


class LoadingAdminBulletinBoardState extends AdminBulletinBoardState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingAdminBulletinBoardState";
  
}

class LoadedAdminBulletinBoardState extends AdminBulletinBoardState{
  final data;

  LoadedAdminBulletinBoardState({
    @required this.data
  });
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadedAdminBulletinBoardState";
}

class MessageBulletinBoardState extends AdminBulletinBoardState{
  final message;
  MessageBulletinBoardState({
    @required this.message
  });
  
  @override
  List<Object> get props => [];
}