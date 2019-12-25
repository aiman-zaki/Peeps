import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class AdminUsersState extends Equatable {
  const AdminUsersState();
}

class InitialAdminUsersState extends AdminUsersState {
  @override
  List<Object> get props => [];
}

class LoadingAdminUsersState extends AdminUsersState{
  @override
  List<Object> get props => [];

  @override
  String toString() => "LoadingAdminUsersState";
}

class LoadedAdminUsersState extends AdminUsersState{
  final data;

  LoadedAdminUsersState({
    @required this.data
  });
  @override
  List<Object> get props =>[];

}