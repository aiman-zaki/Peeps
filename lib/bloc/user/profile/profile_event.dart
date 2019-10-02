import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class UpdateProfileButtonEvent extends ProfileEvent {
  final Map<String,dynamic> user;
  UpdateProfileButtonEvent({
    @required this.user,
  });
  @override
  String toString() => "UpdateProfileEvent";
}

class LoadProfileEvent extends ProfileEvent {
  @override
  String toString() => 'LoadProfileEvent';
}