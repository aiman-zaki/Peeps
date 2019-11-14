import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class GroupworkEvent extends Equatable {
  const GroupworkEvent();

}

class CreateNewGroupworkEvent extends GroupworkEvent{
  final data;
  CreateNewGroupworkEvent(
    {@required this.data});
  
  @override
  String toString() => "NewGroupPressedEvent";

  @override
  List<Object> get props => [data];
} 
class LoadGroupworkEvent extends GroupworkEvent{
  @override
  String toString() => "LoadGroupworkEvent";

  @override
  List<Object> get props => null;
}

