import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final GroupworkRepository groupworkRepository;

  RequestBloc({
    @required this.groupworkRepository,
  });
  @override
  RequestState get initialState => InitialRequestState();

  @override
  Stream<RequestState> mapEventToState(
    RequestEvent event,
  ) async* {
    if(event is LoadRequestsEvent){
      yield LoadingRequestsState();
      var data = await groupworkRepository.readRequests();
      yield LoadedRequestsState(data: data);
    }
    if(event is AnswerButtonClicked){
      await groupworkRepository.updateRequest(data: event.data);
      yield InitialRequestState();
    }
  }
}
