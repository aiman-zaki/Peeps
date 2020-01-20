import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/bulletin_board_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class AdminBulletinBoardBloc extends Bloc<AdminBulletinBoardEvent, AdminBulletinBoardState> {
  final BulletinBoardRepository repository;

  AdminBulletinBoardBloc({
    @required this.repository
  });

  @override
  AdminBulletinBoardState get initialState => InitialAdminBulletinBoardState();

  @override
  Stream<AdminBulletinBoardState> mapEventToState(
    AdminBulletinBoardEvent event,
  ) async* {
    if(event is ReadBulletinBoardEvent){
      yield LoadingAdminBulletinBoardState();
      var data = await repository.readBulletinBoard();
      yield LoadedAdminBulletinBoardState(data: data);
    }
    if(event is CreateBulletinEvent){
      var message = await repository.createBulletin(data: event.data);
      yield MessageBulletinBoardState(message: message['message']);
      this.add(ReadBulletinBoardEvent());
    }
    if(event is DeleteBulletinEvent){
      var message = await repository.deleteBulletin(data: event.data.toJson());
      yield MessageBulletinBoardState(message: message);
      this.add(ReadBulletinBoardEvent());
    }


  }
}
