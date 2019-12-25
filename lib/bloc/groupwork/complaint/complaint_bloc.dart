import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/models/complaint.dart';
import 'package:meta/meta.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import './bloc.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  final GroupworkRepository repository;

  ComplaintBloc({
    @required this.repository,
  });
  @override
  ComplaintState get initialState => InitialComplaintState();

  @override
  Stream<ComplaintState> mapEventToState(
    ComplaintEvent event,
  ) async* {
    if(event is CreateComplaintEvent){
      try{
        var message = await repository.createComplaint(data: event.data.toJson());
        yield MessageComplaintsState(message: message['message']);
        yield InitialComplaintState();
      } catch(e){
        print(e);
        yield MessageComplaintsState(message: e);

      }
    }
  }
}
