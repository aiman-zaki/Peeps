import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileFormState extends Equatable {
  ProfileFormState([List props = const <dynamic>[]]) : super(props);
}

class InitialProfileFormState extends ProfileFormState {
  @override
  String toString() => "InitialProfileFormState";
}

class UpdatingProfileState extends ProfileFormState{
  @override
  String toString() => "UpdatingProfileState";
}

class UpdatedProfileState extends ProfileFormState{
  @override
  String toString() => "UpdatedProfileState";
}

class UploadingProfilePictureState extends ProfileFormState{
  @override
  String toString() => "UploadingProfilePictureState";
}

class UploadedProfilePictureState extends ProfileFormState{
  @override
  String toString() => "UploadedProfilePictureState";
}

class PopState extends ProfileFormState{
  @override
  String toString() => "PopState";
}