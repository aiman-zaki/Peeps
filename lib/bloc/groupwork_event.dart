import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:peeps/models/groupwork.dart';

@immutable
abstract class GroupworkEvent extends Equatable {
  GroupworkEvent([List props = const []]) : super(props);
}

class NewGroupButtonPressedEvent extends GroupworkEvent{
  final String name;
  final String description;
  final String course;
  final List<String> members;
  NewGroupButtonPressedEvent({@required this.name,
                        @required this.description,
                        @required this.course,
                        @required this.members}):super([name,description,course,members]);
  
  @override
  String toString() => "NewGroupPressedEvent";
} 
class LoadGroupworkEvent extends GroupworkEvent{
  final data;

  LoadGroupworkEvent({@required this.data}):super([data]);


  @override
  String toString() => "LoadGroupworkEvent";
}