import 'package:meta/meta.dart';

class Note{
  String note;
  bool pinned;

  Note({
    @required this.note,
    @required this.pinned
  });

  static Note fromJson (Map<String,dynamic> data){
    return Note(
      note: data['note'],
      pinned: data['pinned']
    );
  }

}