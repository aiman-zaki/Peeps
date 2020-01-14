import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class AdminDashboardState extends Equatable {
  const AdminDashboardState();
}

class InitialAdminDashboardState extends AdminDashboardState {
  @override
  List<Object> get props => [];
}

class GeneratingAdminDashboardState extends AdminDashboardState{

  @override
  List<Object> get props => [];

  @override
  String toString() => "GeneratingAdminDashboardState";
}

class GeneratedAdminDashboardState extends AdminDashboardState{
  final data;
  GeneratedAdminDashboardState({
    @required this.data
  });
  @override
  List<Object> get props => [];

  @override
  String toString() => "GeneratedAdminDashboardState";
}