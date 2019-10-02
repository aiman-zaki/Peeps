import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class NoteState extends Equatable {
  const NoteState();
   @override
  List<Object> get props => [];
}

class InitialNoteState extends NoteState {
  @override
  List<Object> get props => [];
}

class LoadingNotesState extends NoteState{
  @override
  String toString() => "LoadingNotesState";
}

class LoadedNotesState extends NoteState{
  final data;
  LoadedNotesState({
    @required this.data
  });
  @override
  String toString() => "LoadedNotesState";
}