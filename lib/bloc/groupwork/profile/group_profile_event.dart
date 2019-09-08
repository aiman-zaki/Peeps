import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GroupProfileEvent extends Equatable {
  GroupProfileEvent([List props = const <dynamic>[]]) : super(props);
}

class UploadProfileImage extends GroupProfileEvent{
  final image;
  final groupId;

  UploadProfileImage({
      @required this.image,
      @required this.groupId
    }
  );
  
  @override
  String toString() => "UploadProfileImage";
}