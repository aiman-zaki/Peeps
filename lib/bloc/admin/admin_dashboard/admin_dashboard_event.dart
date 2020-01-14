import 'package:equatable/equatable.dart';
import 'package:peeps/bloc/admin/admin_dashboard/bloc.dart';
import 'package:meta/meta.dart';

abstract class AdminDashboardEvent extends Equatable {
  const AdminDashboardEvent();
}


class GenerateAdminDashboard extends AdminDashboardEvent{
  final data;
  GenerateAdminDashboard({
    @required this.data
  });
  
  @override
  String toString() => "GenerateAdminDashBoard";

  @override
  List<Object> get props => [];
}