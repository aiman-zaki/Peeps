import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:peeps/resources/common_repo.dart';
import 'package:http/http.dart' as http;

abstract class BaseRepositry{
  final namespace;
  final data;
  final data2;
  
  BaseRepositry(
    {
      @required this.namespace,
      @required this.data,
      this.data2,
    }
  );

   url(){
    if(data2 != null) {
      return "$domain$namespace/$data/$data2";
    } else {
      return "$domain$namespace/$data";
    }
  }
  

  create(dynamic data) async {
    var headers = await fetchHeaders();
    var response = await http.post(url(),
      body: jsonEncode(data),
      headers: headers,
    );
    var jsonDecoded = jsonDecode(response.body);
    if(response.statusCode == 200){
      return jsonDecoded;
    } else {
      throw jsonDecode;
    }
  } 

  read() async {
    var headers = await fetchHeaders();
    var response = await http.get(url(),headers: headers);
    var jsonDecoded = jsonDecode(response.body);
    if(response.statusCode == 200){
      return jsonDecoded;
    } else {
      throw jsonDecode;
    }
  }
  update();
  delete();


}