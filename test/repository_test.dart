import 'package:flutter_test/flutter_test.dart';

import 'dart:convert';





void main(){
  test('User Repository',() async {

  
  });

  test('Chat',() async{
    String json =  '{"date":"2019-08-05 13:11:23.178026"}';
    print(json);
    Map<String,dynamic> jsonMap = jsonDecode(json);
    print(jsonMap);
  });
}