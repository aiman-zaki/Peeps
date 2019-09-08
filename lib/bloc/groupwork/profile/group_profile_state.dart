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

class UploadingProfileImageState extends GroupProfileState{
  @override
  String toString() => "UploadingProfileImageState";
  
}

class UploadedProfileImageState extends GroupProfileState{
  @override
  String toString() => "UploadedProfileImageState";
}
