import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
@immutable
abstract class InviteMembersEvent extends Equatable {
  InviteMembersEvent([List props = const <dynamic>[]]) : super(props);
}

class SearchButtonClickedEvent extends InviteMembersEvent{
  final data;
  SearchButtonClickedEvent({
    @required this.data
  });
  
  @override
  String toString() => "SearchButtonClickedEvent";
}

class InviteMemberEvent extends InviteMembersEvent{
  final data;
  InviteMemberEvent({
    @required this.data
  });

  @override
  String toString() => "InviteMemberEvent";
}