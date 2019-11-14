import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:peeps/resources/note_repository.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {

  final NoteRepository repository;

  NoteBloc({
    @required this.repository
  });

  @override
  NoteState get initialState => InitialNoteState();

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if(event is LoadNotesEvent){
      yield LoadingNotesState();
      final data = await repository.readNotes();
   
      yield LoadedNotesState(data: data);
    }
  }
}
