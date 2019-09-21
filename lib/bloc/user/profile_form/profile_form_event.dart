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

class UploadProfilePictureEvent extends ProfileFormEvent{
  final userId;
  final image;
  UploadProfilePictureEvent({
    @required this.image,
    @required this.userId,
  });

  @override
  String toString() => "UpdateProfilePictureEvent";
}