import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MembersEvent extends Equatable {
  MembersEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadMembersEvent extends MembersEvent{
  final groupId;
  LoadMembersEvent({
    @required this.groupId
  });
  @override
  String toString () => "LoadMembersEvent";
}

class LoadMemberProfile extends MembersEvent{
  @override
  String toString() => "LoadMembersProfile";
}

class SearchButtonClicked extends MembersEvent{
  final search;
  SearchButtonClicked({
    @required this.search
  });
  
  @override
  String toString() => "SearchButtonClicked";
}