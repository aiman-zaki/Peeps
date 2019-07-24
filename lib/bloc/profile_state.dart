import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/models/user.dart';

@immutable
abstract class ProfileState extends Equatable {
  ProfileState([List props = const []]) : super(props);
}

class InitialProfileState extends ProfileState {}


class ProfileLoading extends ProfileState {
  @override
  String toString() => "ProfileLoading";
}

class ProfileLoaded extends ProfileState {
  final UserModel data;
  ProfileLoaded({this.data}):super([data]);

  @override
  String toString() => "ProfileLoaded";
}