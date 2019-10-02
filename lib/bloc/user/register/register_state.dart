import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterState extends Equatable {
  const RegisterState();
   @override
  List<Object> get props => [];
}

class InitialRegisterState extends RegisterState {
  @override
  String toString() => "InitialRegisterState";
}

class RegisteringUserState extends RegisterState{
  final message;
  RegisteringUserState({
    @required this.message,
  });
  @override
  String toString() => "RegisteringUserState";
}

class RegisteredUserState extends RegisterState{
  @override
  String toString() => "RegisteredUserState";
}

class UploadingInitProfilePictureState extends RegisterState{
  @override
  String toString() => "UploadingProfilePictureState";
}

class UploadedInitProfilePictureState extends RegisterState{
  @override
  String toString() => "UploadedProfilePictureState";
}

class CompletedRegisterState extends RegisterState{
  @override
  String toString() => "CompletedRegisterState";
}

class UpdatingProfileInformationState extends RegisterState{
  @override
  String toString() => "UpadtingProfileInformationState";
}
class UpdatedProfileInformationState extends RegisterState{
  @override
  String toString() => "UpdatedProfileInformationState";
}

class ErrorMessageState extends RegisterState{
  final message;
  ErrorMessageState({
    @required this.message
  });
  @override
  String toString() => "ErrorMessageState";
}