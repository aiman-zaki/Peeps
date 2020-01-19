import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/bloc/bloc.dart';

abstract class AdminBulletinBoardEvent extends Equatable {
  const AdminBulletinBoardEvent();
}


class ReadBulletinBoardEvent extends AdminBulletinBoardEvent{
  @override
  List<Object> get props => [];

  @override
  String toString () => "ReadBulletinBoardEvent";
}

class CreateBulletinEvent extends AdminBulletinBoardEvent{
  final data;
  CreateBulletinEvent({
    @required this.data
  });
  @override
  List<Object> get props => [];

  @override
  String toString() => "CreateBulletinEvent";
}

class DeleteBulletinEvent extends AdminBulletinBoardEvent{
  final data;
  DeleteBulletinEvent({
    @required this.data
  });
  @override
  List<Object> get props => [];

  @override
  String toString () => "DeleteBulletinEvent";
}