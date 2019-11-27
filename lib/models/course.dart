import 'package:meta/meta.dart';
class CourseModel{
  final String name;
  final String code;
  CourseModel({
    @required this.name,
    @required this.code
  });

  static CourseModel fromJson(Map<String,dynamic> json){
    return CourseModel(
      code: json['code'],
      name: json['name']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "code":this.code,
      "name":this.name
    };
  }
}