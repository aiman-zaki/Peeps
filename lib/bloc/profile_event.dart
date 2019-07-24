import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const []]) : super(props);
}

class UpdateProfile extends ProfileEvent {
  @override
  String toString() => "UpdateProfile";
}

class LoadProfile extends ProfileEvent {
  @override
  String toString() => 'LoadProfile';
}