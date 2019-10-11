import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class GroupworkEvent extends Equatable {
  const GroupworkEvent();
  @override
  List<Object> get props => [];
}

class NewGroupButtonPressedEvent extends GroupworkEvent{
  final String name;
  final String description;
  final String course;
  final List<String> members;
  NewGroupButtonPressedEvent({@required this.name,
                        @required this.description,
                        @required this.course,
                        @required this.members});
  
  @override
  String toString() => "NewGroupPressedEvent";
} 
class LoadGroupworkEvent extends GroupworkEvent{
  final data;
  LoadGroupworkEvent({@required this.data});
  @override
  String toString() => "LoadGroupworkEvent";
}

