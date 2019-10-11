import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:peeps/resources/groupwork_repository.dart';
import '../bloc.dart';

class GroupProfileBloc extends Bloc<GroupProfileEvent, GroupProfileState> {
  final GroupworkRepository repository;

  GroupProfileBloc({@required this.repository});

  @override
  GroupProfileState get initialState => InitialGroupProfileState();

  @override
  Stream<GroupProfileState> mapEventToState(
    GroupProfileEvent event,
  ) async* {
    if (event is UpdateGroupworkProfileEvent) {
      yield UpdatingGroupProfileState();
      await repository.updateGroupwork(data:event.data);
      yield UpdatedGroupProfileState();

    }
    if (event is UploadGroupworkProfileImage) {
      yield UploadingProfileImageState();
      await repository.uploadProfileImage(event.image, event.groupId);
      yield UploadedProfileImageState();
    }
    if (event is UpdateAdminRoleEvent) {
      yield UpdatingAdminRoleState();
      await repository.updateRoles(data: event.data);
      yield UpdatedAdminRoleState();
    }
    if (event is DeleteMemberEvent) {
      yield DeletingMemberState();
      await repository.updateMembers(data: event.data);
      yield DeletedMemberState();
    }
  }
}
