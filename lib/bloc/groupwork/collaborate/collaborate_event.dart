import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class CollaborateEvent extends Equatable {
  const CollaborateEvent();
}

class InitialCollaborateEvent  extends CollaborateEvent{
  final userData;

  InitialCollaborateEvent({
    @required this.userData
  });

  @override
  String toString() => "InitialCollaborateEvent";


  @override
  List<Object> get props => [userData];

}