import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
@immutable
abstract class InviteMembersEvent extends Equatable {
  const InviteMembersEvent();
  @override
  List<Object> get props => [];
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