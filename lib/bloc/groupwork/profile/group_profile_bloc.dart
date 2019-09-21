import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import 'package:peeps/resources/groupwork_repository.dart';
import '../bloc.dart';

class GroupProfileBloc extends Bloc<GroupProfileEvent, GroupProfileState> {
  final GroupworkRepository repository;

  GroupProfileBloc({
    @required this.repository
  });
  
  @override
  GroupProfileState get initialState => InitialGroupProfileState();

  @override
  Stream<GroupProfileState> mapEventToState(
    GroupProfileEvent event,
  ) async* {
   if(event is UploadGroupworkProfileImage){
     yield UploadingProfileImageState();
     await repository.uploadProfileImage(event.image, event.groupId);
     yield UploadedProfileImageState();
   }
  }
}
