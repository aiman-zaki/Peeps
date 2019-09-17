import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileFormEvent extends Equatable {
  ProfileFormEvent([List props = const <dynamic>[]]) : super(props);
}

class UpdateProfileEvent extends ProfileFormEvent{
  final data;
  UpdateProfileEvent({
    @required this.data
  });
  
  @override
  String toString() => "UpdateProfileEvent";
}