import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GroupProfileState extends Equatable {
  GroupProfileState([List props = const <dynamic>[]]) : super(props);
}
class InitialGroupProfileState extends GroupProfileState {
  @override
  String toString() => "InitialGroupProfileState";
}

class UpdatingGroupProfileState extends GroupProfileState{
  @override
  String toString() => "UpdatingGroupProfileState";
}

class UpdatedGroupProfileState extends GroupProfileState{
  @override
  String toString() => "UpdatedGroupProfileState";
}

class UploadingProfileImageState extends GroupProfileState{
  @override
  String toString() => "UploadingProfileImageState";
  
}
class UploadedProfileImageState extends GroupProfileState{
  @override
  String toString() => "UploadedProfileImageState";
}
class UpdatingAdminRoleState extends GroupProfileState{
  @override
  String toString() => "UpdatingAdminROleState";
}
class UpdatedAdminRoleState extends GroupProfileState{
  @override
  String toString() => "UpdatedAdminRoleState";
}
class DeletingMemberState extends GroupProfileState{
  @override
  String toString() => "DeletingMemberState";
}
class DeletedMemberState extends GroupProfileState{
  @override
  String toString() => "DeletedMemberState";
}