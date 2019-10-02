import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class LoadNotesEvent extends NoteEvent{
  final data;
  
  LoadNotesEvent({
    @required this.data
  });

  @override
  String toString() => "LoadNotesEvent";
}