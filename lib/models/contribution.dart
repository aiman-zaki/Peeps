import 'package:meta/meta.dart';

class ContributionModel{
  final String id;
  final String who;
  final String what;
  final DateTime when;
  //Where [CRUD]
  final String where;
  final String why;
  final String how;
  final String room;

  ContributionModel({
    this.id,
    @required this.who,
    @required this.what,
    @required this.where,
    @required this.when,
    @required this.why,
    @required this.how,
    this.room,
    
  });

  static ContributionModel fromJson(Map<String,dynamic> json){
    return ContributionModel(
  
      who: json['who'],
      what: json['what'],
      when: DateTime.parse(json['when']),
      where: json['where'],
      why: json['why'],
      how: json['how'], 
    );
  }

  Map<String,dynamic> toJson(){
    return {
 
      "who":this.who,
      "what":this.what,
      "when":this.when.toString(),
      "where":this.where,
      "why":this.why,
      "how":this.how,
      "room":this.room,
    };
  }

  String display(){
    return "${what.toUpperCase()} $where $why -> $how";
  }


} 