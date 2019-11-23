import 'package:meta/meta.dart';


class PointsModel{
  final String email;
  final double points;
  final DateTime updatedDate;

  PointsModel({
    @required this.email,
    @required this.points,
    @required this.updatedDate,
  });

  static PointsModel fromJson(Map<String,dynamic> json){
    return PointsModel(
      email: json['email'],
      points: json['points'],
      updatedDate: DateTime.parse(json['updated_date'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "email":this.email,
      "points":this.points,
      "updated_date":this.updatedDate,
    };
  }

}