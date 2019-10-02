import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/models/user.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class InitialProfileState extends ProfileState {}


class ProfileLoading extends ProfileState {
  @override
  String toString() => "ProfileLoading";
}

class ProfileLoaded extends ProfileState {
  final UserModel data;
  ProfileLoaded({this.data});

  @override
  String toString() => "ProfileLoaded";
}

class NoProfileLoaded extends ProfileState{
  @override
  String toString() => "NoProfileLoaded";
}

class ProfileErrorMessageState extends ProfileState{
  final String message;

  ProfileErrorMessageState({
    @required this.message
  });
  
  @override
  String toString() => "ErrorMessageState";
}